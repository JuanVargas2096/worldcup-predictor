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
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

/**
 * Punto de extensión para conectar con una API real (API-Football).
 */
@ApplicationScoped
@Typed(ExternalApiFootballDataProvider.class)
public class ExternalApiFootballDataProvider implements FootballDataProvider {

    private static final Logger LOG = Logger.getLogger(ExternalApiFootballDataProvider.class);

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
            LOG.warn("ExternalApiFootballDataProvider sin API key válida (football.api.key). "
                    + "Configura FOOTBALL_API_KEY.");
            return 0;
        }

        List<Team> teams = Team.listAll();
        int totalImported = 0;

        for (Team team : teams) {
            if (team.apiId == null) {
                LOG.debugf("Omitiendo %s: api_id no configurado.", team.code);
                continue;
            }

            if (!configService.canMakeApiCall()) {
                LOG.warn("Límite de peticiones diarias a la API alcanzado. Deteniendo importación.");
                break;
            }

            // Buscamos los últimos 5 partidos terminados de cada selección
            try {
                ApiFootballResponse<ApiFixture> response = apiClient.getFixtures(
                        apiKey.get(), team.apiId, 5, "FT");

                configService.registerApiCall();

                if (response != null && response.response() != null) {
                    for (ApiFixture apiMatch : response.response()) {
                        if (persistIfMissing(apiMatch)) {
                            totalImported++;
                        }
                    }
                }
            } catch (Exception e) {
                LOG.errorf("Error importando partidos para %s: %s", team.code, e.getMessage());
            }
        }

        LOG.infof("ExternalApiFootballDataProvider importó %d nuevos partidos.", totalImported);
        return totalImported;
    }

    private boolean persistIfMissing(ApiFixture api) {
        // Lógica para evitar duplicados y mapear a nuestro MatchResult
        // Usamos el API ID para un mapeo más robusto que el nombre
        Team home = Team.findByApiId(api.teams().home().id());
        Team away = Team.findByApiId(api.teams().away().id());

        if (home == null || away == null) return false;

        LocalDate matchDate = ZonedDateTime.parse(api.fixture().date()).toLocalDate();

        // Evitar duplicados por fecha y equipos
        long count = MatchResult.count("matchDate = ?1 and homeTeam = ?2 and awayTeam = ?3",
                matchDate, home, away);
        if (count > 0) return false;

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
}
