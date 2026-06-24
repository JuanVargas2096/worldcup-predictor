package com.worldcup.provider;

import com.worldcup.config.ApiRateLimit;
import com.worldcup.config.ConfigurationService;
import com.worldcup.match.MatchResult;
import com.worldcup.provider.dto.ApiFixture;
import com.worldcup.provider.dto.ApiFootballResponse;
import com.worldcup.team.Team;
import io.quarkus.narayana.jta.QuarkusTransaction;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Typed;
import jakarta.inject.Inject;
import org.eclipse.microprofile.rest.client.inject.RestClient;
import org.jboss.logging.Logger;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.UUID;

/**
 * Importa forma reciente real desde API-Football y la PERSISTE en BD.
 *
 * Diseño (igual que el sync del Mundial): la llamada HTTP se hace SIEMPRE fuera de
 * transacción; la persistencia se realiza en transacciones cortas con
 * {@link QuarkusTransaction}. Nunca se retiene una conexión de BD mientras se
 * espera a la API, de modo que las pantallas (ranking/detalle) leen siempre de BD
 * sin bloquearse. La invoca el scheduler (no on-demand en la ruta de petición).
 *
 * Los partidos reales se guardan con matchType = "EXTERNAL". Al importar real para
 * un equipo se eliminan sus partidos "MOCK" (sembrados al arranque).
 */
@ApplicationScoped
@Typed(ExternalApiFootballDataProvider.class)
public class ExternalApiFootballDataProvider implements FootballDataProvider {

    private static final Logger log = Logger.getLogger(ExternalApiFootballDataProvider.class);
    private static final int TAKE_MATCHES = 5;   // partidos de forma a guardar por equipo
    private static final int FETCH_LAST = 10;    // cuántos pedir a la API (luego filtramos jugados)
    private static final int STALE_HOURS = 12;   // refrescar si la última importación es más vieja que esto

    @Inject
    @RestClient
    ApiFootballClient apiClient;

    @Inject
    ConfigurationService configService;

    private record TeamRef(UUID id, Integer apiId, String code) {}

    @Override
    public String name() {
        return "external";
    }

    @Override
    public int refreshRecentMatches() {
        return refreshRecentMatches(false);
    }

    /** force=true ignora la antigüedad y refresca todos los equipos (p. ej. botón manual). */
    public int refreshRecentMatches(boolean force) {
        String apiKey = configService.getApiKey();
        if (apiKey == null) {
            log.warn("ExternalApiFootballDataProvider sin API key válida (configuration.FOOTBALL_API_KEY).");
            return 0;
        }

        // 1) Cargar referencias de equipos en una transacción corta.
        List<TeamRef> teams = QuarkusTransaction.requiringNew().call(() ->
                Team.<Team>listAll().stream()
                        .map(t -> new TeamRef(t.id, t.apiId, t.code))
                        .toList());

        // Intervalo entre llamadas para no exceder el límite por minuto de la API (evita 429).
        long intervalMs = configService.getApiMinIntervalMs();

        int totalImported = 0;
        int calls = 0;
        for (TeamRef ref : teams) {
            if (ref.apiId() == null) {
                continue;
            }

            // ¿Su forma ya está fresca? (importada hace < STALE_HOURS) -> saltar para no gastar cuota.
            boolean fresh = QuarkusTransaction.requiringNew().call(() ->
                    MatchResult.count("matchType = 'EXTERNAL' and createdAt > ?1 and (homeTeam.id = ?2 or awayTeam.id = ?2)",
                            LocalDateTime.now().minusHours(STALE_HOURS), ref.id()) > 0);
            if (!force && fresh) {
                continue;
            }

            if (!configService.canMakeApiCall()) {
                log.warn("Límite diario de peticiones a la API alcanzado. Deteniendo importación.");
                break;
            }

            // Throttle: espacia las llamadas (salvo la primera) para respetar el límite por minuto.
            if (calls > 0) {
                ApiRateLimit.throttle(intervalMs);
            }

            try {
                log.infof("Consultando últimos partidos de %s (apiId %d)...", ref.code(), ref.apiId());
                // 2) Llamada HTTP SIN transacción abierta. 'last' trae los partidos más
                //    recientes de CUALQUIER competición, incluido el Mundial 2026 en curso.
                ApiFootballResponse<ApiFixture> response =
                        apiClient.getFixtures(apiKey, null, null, ref.apiId(), FETCH_LAST, null);
                configService.registerApiCall();
                calls++;

                // La API devuelve 200 con un bloque errors cuando se agota la cuota diaria.
                if (response != null && ApiRateLimit.isRateLimitErrors(response.errors())) {
                    log.warnf("Rate limit/cuota de la API alcanzada (errors=%s). Deteniendo importación.",
                            response.errors());
                    break;
                }

                if (response == null || response.response() == null || response.response().isEmpty()) {
                    log.warnf("Sin partidos recientes para %s.", ref.code());
                    continue;
                }

                // Solo partidos jugados (con marcador), más recientes primero, máx. 5.
                List<ApiFixture> recent = response.response().stream()
                        .filter(f -> f.goals() != null && f.goals().home() != null && f.goals().away() != null)
                        .sorted((a, b) -> b.fixture().date().compareTo(a.fixture().date()))
                        .limit(TAKE_MATCHES)
                        .toList();

                if (recent.isEmpty()) {
                    continue;
                }

                // 3) Persistir en transacción corta (reemplaza la forma anterior del equipo).
                int imported = QuarkusTransaction.requiringNew().call(() -> replaceTeamMatches(ref.id(), recent));
                totalImported += imported;
            } catch (Exception e) {
                if (ApiRateLimit.isRateLimited(e)) {
                    log.warnf("Rate limit de la API alcanzado (%s). Deteniendo importación; se reanudará luego.",
                            e.getMessage());
                    break;
                }
                log.errorf("Error importando partidos para %s: %s", ref.code(), e.getMessage());
            }
        }

        log.infof("ExternalApiFootballDataProvider importó %d partidos reales.", totalImported);
        return totalImported;
    }

    /** Reemplaza la forma reciente de un equipo (borra MOCK + EXTERNAL e inserta los nuevos). */
    int replaceTeamMatches(UUID teamId, List<ApiFixture> matches) {
        Team team = Team.findById(teamId);
        if (team == null) return 0;

        // Borra la forma anterior de ESTE equipo (simulada o real) para dejar datos al día.
        MatchResult.delete("(matchType = 'MOCK' or matchType = 'EXTERNAL') and (homeTeam.id = ?1 or awayTeam.id = ?1)", teamId);

        int imported = 0;
        for (ApiFixture api : matches) {
            if (persistIfMissing(api)) {
                imported++;
            }
        }
        return imported;
    }

    private boolean persistIfMissing(ApiFixture api) {
        Team home = findOrCreateTeam(api.teams().home());
        Team away = findOrCreateTeam(api.teams().away());
        if (home == null || away == null) return false;
        if (api.goals() == null || api.goals().home() == null || api.goals().away() == null) return false;

        LocalDate matchDate = parseDate(api.fixture().date());

        long count = MatchResult.count("matchDate = ?1 and homeTeam = ?2 and awayTeam = ?3",
                matchDate, home, away);
        if (count > 0) return false;

        MatchResult m = new MatchResult();
        m.matchDate = matchDate;
        m.homeTeam = home;
        m.awayTeam = away;
        m.homeScore = api.goals().home();
        m.awayScore = api.goals().away();
        m.competition = api.league() != null ? api.league().name() : "Internacional";
        m.matchType = "EXTERNAL";
        m.persist();
        return true;
    }

    private Team findOrCreateTeam(ApiFixture.TeamDetail info) {
        if (info == null || info.id() == null) return null;
        Team t = Team.findByApiId(info.id());
        if (t != null) return t;

        t = Team.find("name", info.name()).firstResult();
        if (t != null) {
            t.apiId = info.id();
            t.persist();
            return t;
        }

        t = new Team();
        t.apiId = info.id();
        t.name = info.name();
        t.code = uniqueCode(info.name());
        t.flagEmoji = "🏳️";
        t.persist();
        return t;
    }

    private String uniqueCode(String name) {
        String base = (name != null && name.length() >= 3)
                ? name.substring(0, 3).toUpperCase()
                : ((name == null ? "XXX" : name.toUpperCase()) + "XXX").substring(0, 3);
        String code = base;
        int suffix = 0;
        while (Team.findByCode(code) != null && suffix < 100) {
            code = base.substring(0, 2) + Integer.toString(suffix, 36).toUpperCase();
            suffix++;
        }
        return code;
    }

    private LocalDate parseDate(String dateStr) {
        if (dateStr == null) return LocalDate.now();
        try {
            if (dateStr.contains("+") || dateStr.endsWith("Z")) {
                return ZonedDateTime.parse(dateStr).toLocalDate();
            }
            return LocalDateTime.parse(dateStr).toLocalDate();
        } catch (Exception e) {
            try {
                return LocalDate.parse(dateStr.substring(0, 10));
            } catch (Exception e2) {
                return LocalDate.now();
            }
        }
    }
}
