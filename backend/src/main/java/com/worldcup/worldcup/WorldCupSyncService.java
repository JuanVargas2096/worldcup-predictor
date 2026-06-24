package com.worldcup.worldcup;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.worldcup.provider.ApiFootballClient;
import com.worldcup.provider.dto.ApiFixture;
import com.worldcup.provider.dto.ApiFootballResponse;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.rest.client.inject.RestClient;
import org.jboss.logging.Logger;

import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.util.Optional;

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

    @Transactional
    public SyncResult syncWorldCup(Integer leagueId, Integer season) {
        LOG.infof("Iniciando sincronización del Mundial (league: %d, season: %d)...", leagueId, season);
        SyncResult result = new SyncResult();
        result.startedAt = LocalDateTime.now();

        if (apiKey.isEmpty()) {
            LOG.error("API Key no configurada.");
            result.status = "ERROR: API Key missing";
            result.finishedAt = LocalDateTime.now();
            return result;
        }

        try {
            ApiFootballResponse<ApiFixture> response = apiClient.getFixtures(apiKey.get(), leagueId, season, null, null, null);
            
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

            result.totalFixturesReceived = response.response().size();
            LOG.infof("Recibidos %d fixtures.", result.totalFixturesReceived);

            for (ApiFixture apiFixture : response.response()) {
                try {
                    processFixture(apiFixture, result);
                } catch (Exception e) {
                    LOG.errorf("Error procesando fixture %d: %s", apiFixture.fixture().id(), e.getMessage());
                }
            }

            result.status = "SUCCESS";
        } catch (Exception e) {
            LOG.error("Error en la sincronización", e);
            result.status = "ERROR: " + e.getMessage();
        }

        result.finishedAt = LocalDateTime.now();
        LOG.infof("Sincronización finalizada con estado: %s. Equipos (I:%d, U:%d), Fixtures (I:%d, U:%d)", 
                result.status, result.teamsInserted, result.teamsUpdated, result.fixturesInserted, result.fixturesUpdated);
        return result;
    }

    private void processFixture(ApiFixture apiFixture, SyncResult result) throws Exception {
        // Equipos
        WorldCupTeam home = upsertTeam(apiFixture.teams().home(), result);
        WorldCupTeam away = upsertTeam(apiFixture.teams().away(), result);

        // Fixture
        upsertFixture(apiFixture, home, away, result);
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

    private void upsertFixture(ApiFixture apiFixture, WorldCupTeam home, WorldCupTeam away, SyncResult result) throws Exception {
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

        // Mapping fields
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
