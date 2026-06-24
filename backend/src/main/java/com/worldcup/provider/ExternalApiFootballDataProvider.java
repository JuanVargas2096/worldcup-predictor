package com.worldcup.provider;

import com.worldcup.config.ConfigurationService;
import com.worldcup.match.MatchResult;
import com.worldcup.provider.dto.ApiFixture;
import com.worldcup.provider.dto.ApiFootballResponse;
import com.worldcup.team.Team;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Typed;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.rest.client.inject.RestClient;
import org.jboss.logging.Logger;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

/**
 * Punto de extensión para conectar con una API real (API-Football).
 * 
 * FILOSOFÍA DE TOKENS: Para minimizar el consumo de créditos de la API externa
 * y tokens de procesamiento, este proveedor prioriza la persistencia en BD.
 * Una vez que los partidos están en la base de datos, el sistema de scoring
 * trabaja exclusivamente con los datos locales (Offline-First).
 */
@ApplicationScoped
@Typed(ExternalApiFootballDataProvider.class)
public class ExternalApiFootballDataProvider implements FootballDataProvider {

    private static final Logger log = Logger.getLogger(ExternalApiFootballDataProvider.class);

    @ConfigProperty(name = "football.api.key")
    Optional<String> apiKey;

    @Inject
    @RestClient
    ApiFootballClient apiClient;

    @Inject
    ConfigurationService configService;

    @Override
    public String name() {
        return "external";
    }

    @Override
    @Transactional
    public int refreshRecentMatches() {
        if (apiKey.isEmpty() || "NO_KEY".equals(apiKey.get()) || "REPLAZA_ESTO_CON_TU_KEY".equals(apiKey.get())) {
            log.warn("ExternalApiFootballDataProvider sin API key válida (football.api.key). "
                    + "Configura FOOTBALL_API_KEY.");
            return 0;
        }

        List<Team> teams = Team.listAll();
        int totalImported = 0;

        for (Team team : teams) {
            if (team.apiId == null) {
                log.debugf("Omitiendo %s: api_id no configurado.", team.code);
                continue;
            }

            // FILOSOFÍA TOKENS: Antes de llamar a la API, verificamos si ya tenemos 
            // suficientes partidos en la BD para este equipo.
            long localMatches = MatchResult.count("homeTeam = ?1 or awayTeam = ?1", team);
            if (localMatches >= 5) {
                log.debugf("Saltando importación para %s: Ya existen %d partidos en BD.", team.code, localMatches);
                continue;
            }

            if (!configService.canMakeApiCall()) {
                log.warn("Límite de peticiones diarias a la API alcanzado. Deteniendo importación.");
                break;
            }

            // Buscamos partidos de la temporada 2024 (compatible con plan gratuito)
            // Filtramos los últimos 5 localmente para evitar la restricción del parámetro 'last'
            try {
                log.infof("Consultando partidos para %s (apiId: %d)...", team.code, team.apiId);
                ApiFootballResponse<ApiFixture> response = apiClient.getFixtures(
                        apiKey.get(), null, 2024, team.apiId, null, "FT");

                configService.registerApiCall();

                if (response != null && response.response() != null && !response.response().isEmpty()) {
                    List<ApiFixture> matches = response.response();
                    // Ordenar por fecha descendente
                    matches.sort((a, b) -> b.fixture().date().compareTo(a.fixture().date()));
                    
                    log.infof("API devolvió %d partidos para %s. Procesando los 5 más recientes.", matches.size(), team.code);
                    int importedForTeam = 0;
                    for (int i = 0; i < Math.min(5, matches.size()); i++) {
                        if (persistIfMissing(matches.get(i))) {
                            importedForTeam++;
                            totalImported++;
                        }
                    }
                } else if (response != null && response.errors() != null && !response.errors().toString().equals("[]") && !response.errors().toString().equals("{}")) {
                    log.errorf("Error de la API para %s: %s", team.code, response.errors());
                } else {
                    log.warnf("No se encontraron partidos finalizados para %s en la temporada 2024.", team.code);
                }
            } catch (Exception e) {
                log.errorf("Error invocando API para %s: %s", team.code, e.getMessage());
            }
        }

        log.infof("ExternalApiFootballDataProvider importó %d nuevos partidos.", totalImported);
        return totalImported;
    }

    private boolean persistIfMissing(ApiFixture api) {
        // Lógica para evitar duplicados y mapear a nuestro MatchResult
        Team home = findOrCreateTeam(api.teams().home());
        Team away = findOrCreateTeam(api.teams().away());

        if (home == null || away == null) return false;

        LocalDate matchDate = parseDate(api.fixture().date());

        // Evitar duplicados por fecha y equipos
        long count = MatchResult.count("matchDate = ?1 and homeTeam = ?2 and awayTeam = ?3",
                matchDate, home, away);
        if (count > 0) {
            log.debugf("Partido ya existe: %s vs %s el %s", home.code, away.code, matchDate);
            return false;
        }

        MatchResult m = new MatchResult();
        m.matchDate = matchDate;
        m.homeTeam = home;
        m.awayTeam = away;
        m.homeScore = api.goals().home();
        m.awayScore = api.goals().away();
        m.competition = api.league().name();
        m.matchType = "EXTERNAL";
        m.persist();
        return true;
    }

    private Team findOrCreateTeam(ApiFixture.TeamDetail info) {
        Team t = Team.findByApiId(info.id());
        if (t == null) {
            // Si no está por api_id, lo buscamos por nombre exacto para evitar duplicados
            t = Team.find("name", info.name()).firstResult();
            
            if (t == null) {
                log.debugf("Creando equipo externo: %s", info.name());
                t = new Team();
                t.apiId = info.id();
                t.name = info.name();
                // Generamos un código único basado en el nombre y el ID (máximo 3 caracteres)
                String baseCode = (info.name().length() >= 3) 
                    ? info.name().substring(0, 3).toUpperCase() 
                    : (info.name().toUpperCase() + "XX").substring(0, 3);
                
                String finalCode = baseCode;
                int suffix = 0;
                // Si el código ya existe, buscamos una alternativa usando números de forma incremental
                while (Team.findByCode(finalCode) != null && suffix < 100) {
                    if (suffix < 10) {
                        // Intentamos algo como NO0, NO1...
                        finalCode = baseCode.substring(0, 2) + suffix;
                    } else {
                        // Intentamos algo como N10, N11...
                        finalCode = baseCode.substring(0, 1) + (suffix % 100);
                    }
                    suffix++;
                }
                t.code = finalCode;
                t.flagEmoji = "🏳️"; // Bandera genérica para externos
                t.persist();
            } else {
                // Si existía por nombre pero no tenía api_id, se lo ponemos
                t.apiId = info.id();
                t.persist();
            }
        }
        return t;
    }

    private LocalDate parseDate(String dateStr) {
        if (dateStr == null) return LocalDate.now();
        try {
            // API-Football suele enviar ISO con zona horaria
            if (dateStr.contains("+") || dateStr.endsWith("Z")) {
                return ZonedDateTime.parse(dateStr).toLocalDate();
            }
            // Fallback para ISO sin zona horaria
            return LocalDateTime.parse(dateStr).toLocalDate();
        } catch (Exception e) {
            log.debugf("Formato de fecha no estándar (%s), intentando extracción básica", dateStr);
            try {
                // Si falla, tomamos los primeros 10 caracteres (YYYY-MM-DD)
                return LocalDate.parse(dateStr.substring(0, 10));
            } catch (Exception e2) {
                log.errorf("Imposible parsear fecha: %s", dateStr);
                return LocalDate.now();
            }
        }
    }
}
