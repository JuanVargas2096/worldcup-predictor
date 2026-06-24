package com.worldcup.worldcup;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.worldcup.provider.ApiFootballClient;
import com.worldcup.provider.dto.ApiFixture;
import com.worldcup.provider.dto.ApiFootballResponse;
import io.quarkus.narayana.jta.QuarkusTransaction;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.rest.client.inject.RestClient;
import org.jboss.logging.Logger;

import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

/**
 * Sincroniza equipos y partidos reales del Mundial desde API-Football.
 *
 * IMPORTANTE (rendimiento/estabilidad): la llamada HTTP se hace FUERA de cualquier
 * transacción. La persistencia se realiza en transacciones cortas (una por fixture)
 * con {@link QuarkusTransaction}, de modo que NUNCA se retiene una conexión de BD
 * mientras se espera la respuesta de la API. Así el resto de endpoints (p. ej. el
 * detalle de equipo) nunca quedan bloqueados por el pool de conexiones.
 */
@ApplicationScoped
public class WorldCupSyncService {

    private static final Logger LOG = Logger.getLogger(WorldCupSyncService.class);

    @Inject
    @RestClient
    ApiFootballClient apiClient;

    @ConfigProperty(name = "football.api.key")
    Optional<String> apiKey;

    @Inject
    ObjectMapper objectMapper;

    public SyncResult syncWorldCup(Integer leagueId, Integer season) {
        LOG.infof("Iniciando sincronización del Mundial (league: %d, season: %d)...", leagueId, season);
        SyncResult result = new SyncResult();
        result.startedAt = LocalDateTime.now();

        if (apiKey.isEmpty() || "NO_KEY".equals(apiKey.get())) {
            LOG.error("API Key no configurada (football.api.key / FOOTBALL_API_KEY).");
            result.status = "ERROR: API Key missing";
            result.finishedAt = LocalDateTime.now();
            return result;
        }

        try {
            // 1) Llamada HTTP SIN transacción abierta.
            ApiFootballResponse<ApiFixture> response =
                    apiClient.getFixtures(apiKey.get(), leagueId, season, null, null, null);

            if (response == null || response.response() == null) {
                LOG.warn("Respuesta vacía o nula de la API.");
                result.status = "WARNING: Empty response";
                result.finishedAt = LocalDateTime.now();
                return result;
            }

            if (response.errors() != null) {
                String errorsStr = response.errors().toString();
                if (!"[]".equals(errorsStr) && !"{}".equals(errorsStr)) {
                    LOG.errorf("La API devolvió errores: %s", response.errors());
                    result.status = "ERROR: API errors: " + errorsStr;
                    result.finishedAt = LocalDateTime.now();
                    return result;
                }
            }

            List<ApiFixture> fixtures = response.response();
            result.totalFixturesReceived = fixtures.size();
            LOG.infof("Recibidos %d fixtures.", result.totalFixturesReceived);

            // 2) Persistencia en transacciones cortas (una por fixture).
            for (ApiFixture apiFixture : fixtures) {
                try {
                    QuarkusTransaction.requiringNew().run(() -> persistFixture(apiFixture, result));
                } catch (Exception e) {
                    Integer fid = apiFixture.fixture() != null ? apiFixture.fixture().id() : null;
                    LOG.errorf("Error procesando fixture %s: %s", fid, e.getMessage());
                }
            }

            result.status = "SUCCESS";
        } catch (Exception e) {
            LOG.error("Error en la sincronización", e);
            result.status = "ERROR: " + e.getMessage();
        }

        result.finishedAt = LocalDateTime.now();
        LOG.infof("Sincronización finalizada: %s. Equipos (I:%d, U:%d), Fixtures (I:%d, U:%d)",
                result.status, result.teamsInserted, result.teamsUpdated,
                result.fixturesInserted, result.fixturesUpdated);
        return result;
    }

    /** Persiste un fixture y sus equipos. Se ejecuta dentro de una transacción. */
    void persistFixture(ApiFixture apiFixture, SyncResult result) {
        try {
            WorldCupTeam home = upsertTeam(apiFixture.teams().home(), result);
            WorldCupTeam away = upsertTeam(apiFixture.teams().away(), result);
            upsertFixture(apiFixture, home, away, result);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private WorldCupTeam upsertTeam(ApiFixture.TeamDetail apiTeam, SyncResult result) {
        if (apiTeam == null || apiTeam.id() == null) return null;

        WorldCupTeam team = WorldCupTeam.findByApiId(apiTeam.id());
        boolean isNew = false;
        if (team == null) {
            team = new WorldCupTeam();
            team.apiTeamId = apiTeam.id();
            isNew = true;
        }
        team.name = apiTeam.name();
        team.logoUrl = apiTeam.logo();
        team.updatedAt = LocalDateTime.now();
        team.persist();

        if (isNew) result.teamsInserted++; else result.teamsUpdated++;
        return team;
    }

    private void upsertFixture(ApiFixture apiFixture, WorldCupTeam home, WorldCupTeam away, SyncResult result)
            throws Exception {
        if (apiFixture.fixture() == null || apiFixture.fixture().id() == null) {
            LOG.warn("Fixture sin ID recibido, saltando...");
            return;
        }

        WorldCupFixture fixture = WorldCupFixture.findByApiId(apiFixture.fixture().id());
        boolean isNew = false;
        if (fixture == null) {
            fixture = new WorldCupFixture();
            fixture.apiFixtureId = apiFixture.fixture().id();
            isNew = true;
        }

        if (apiFixture.league() != null) {
            fixture.leagueId = apiFixture.league().id();
            fixture.leagueName = apiFixture.league().name();
            fixture.season = apiFixture.league().season();
            fixture.round = apiFixture.league().round();
        }

        fixture.referee = apiFixture.fixture().referee();
        fixture.timezone = apiFixture.fixture().timezone();
        if (apiFixture.fixture().date() != null) {
            try {
                fixture.fixtureDate = ZonedDateTime.parse(apiFixture.fixture().date()).toLocalDateTime();
            } catch (Exception e) {
                LOG.debugf("Error parseando fecha %s: %s", apiFixture.fixture().date(), e.getMessage());
            }
        }
        fixture.fixtureTimestamp = apiFixture.fixture().timestamp();

        if (apiFixture.fixture().venue() != null) {
            fixture.venueId = apiFixture.fixture().venue().id();
            fixture.venueName = apiFixture.fixture().venue().name();
            fixture.venueCity = apiFixture.fixture().venue().city();
        }

        if (apiFixture.fixture().status() != null) {
            fixture.statusLong = apiFixture.fixture().status().longStatus();
            fixture.statusShort = apiFixture.fixture().status().shortStatus();
            fixture.elapsed = apiFixture.fixture().status().elapsed();
            fixture.extra = apiFixture.fixture().status().extra();
        }

        fixture.homeTeam = home;
        fixture.awayTeam = away;
        fixture.homeWinner = apiFixture.teams().home().winner();
        fixture.awayWinner = apiFixture.teams().away().winner();

        if (apiFixture.goals() != null) {
            fixture.goalsHome = apiFixture.goals().home();
            fixture.goalsAway = apiFixture.goals().away();
        }

        if (apiFixture.score() != null) {
            if (apiFixture.score().halftime() != null) {
                fixture.halftimeHome = apiFixture.score().halftime().home();
                fixture.halftimeAway = apiFixture.score().halftime().away();
            }
            if (apiFixture.score().fulltime() != null) {
                fixture.fulltimeHome = apiFixture.score().fulltime().home();
                fixture.fulltimeAway = apiFixture.score().fulltime().away();
            }
            if (apiFixture.score().extratime() != null) {
                fixture.extratimeHome = apiFixture.score().extratime().home();
                fixture.extratimeAway = apiFixture.score().extratime().away();
            }
            if (apiFixture.score().penalty() != null) {
                fixture.penaltyHome = apiFixture.score().penalty().home();
                fixture.penaltyAway = apiFixture.score().penalty().away();
            }
        }

        fixture.rawResponse = objectMapper.writeValueAsString(apiFixture);
        fixture.updatedAt = LocalDateTime.now();
        fixture.persist();

        if (isNew) result.fixturesInserted++; else result.fixturesUpdated++;
    }
}
