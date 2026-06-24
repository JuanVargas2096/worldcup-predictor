package com.worldcup.worldcup;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.worldcup.config.ConfigurationService;
import com.worldcup.provider.ApiFootballClient;
import com.worldcup.provider.dto.ApiFootballResponse;
import com.worldcup.provider.dto.ApiPrediction;
import com.worldcup.worldcup.KnockoutBracket.Round;
import io.quarkus.narayana.jta.QuarkusTransaction;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import org.eclipse.microprofile.rest.client.inject.RestClient;
import org.jboss.logging.Logger;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Predicciones (% de avanzar por partido) y armado del bracket de eliminatorias del Mundial.
 *
 * Filosofía DB-first (como {@link WorldCupSyncService}): la llamada HTTP a /predictions se hace
 * SIEMPRE fuera de transacción; la persistencia va en transacciones cortas con
 * {@link QuarkusTransaction}. El refresco está acotado por la cuota diaria de la API
 * ({@link ConfigurationService}). El armado del bracket es 100% lectura de BD.
 */
@ApplicationScoped
public class WorldCupPredictionService {

    private static final Logger LOG = Logger.getLogger(WorldCupPredictionService.class);

    /** Horas tras las que se refresca la predicción de un partido aún no finalizado. */
    private static final long STALE_HOURS = 12;

    @Inject
    @RestClient
    ApiFootballClient apiClient;

    @Inject
    ObjectMapper objectMapper;

    @Inject
    ConfigurationService configurationService;

    // ---------------------------------------------------------------------------------------------
    // Refresco de predicciones (HTTP)
    // ---------------------------------------------------------------------------------------------

    /**
     * Trae y persiste las predicciones de los partidos de eliminatoria con ambos equipos definidos.
     * Devuelve cuántas predicciones se actualizaron.
     */
    public int refreshPredictions(Integer season) {
        String apiKey = configurationService.getApiKey();
        if (apiKey == null) {
            LOG.debug("Sin API key (configuration.FOOTBALL_API_KEY): se omite el refresco de predicciones.");
            return 0;
        }

        List<Integer> fixtureIds = QuarkusTransaction.requiringNew().call(() -> idsNeedingPrediction(season));
        if (fixtureIds.isEmpty()) {
            LOG.debug("No hay partidos de eliminatoria que requieran predicción.");
            return 0;
        }

        int updated = 0;
        for (Integer fixtureId : fixtureIds) {
            if (!configurationService.canMakeApiCall()) {
                LOG.warnf("Cuota diaria de API agotada; se detiene el refresco de predicciones (pendientes: %d).",
                        fixtureIds.size() - updated);
                break;
            }
            try {
                ApiFootballResponse<ApiPrediction> resp = apiClient.getPredictions(apiKey, fixtureId);
                configurationService.registerApiCall();
                if (resp == null || resp.response() == null || resp.response().isEmpty()) {
                    LOG.debugf("Sin predicción para el fixture %d.", fixtureId);
                    continue;
                }
                ApiPrediction prediction = resp.response().get(0);
                QuarkusTransaction.requiringNew().run(() -> persistPrediction(fixtureId, prediction));
                updated++;
            } catch (Exception e) {
                LOG.errorf("Error obteniendo predicción del fixture %d: %s", fixtureId, e.getMessage());
            }
        }
        LOG.infof("Predicciones refrescadas: %d.", updated);
        return updated;
    }

    /** IDs (api_fixture_id) de partidos de knockout con ambos equipos definidos que necesitan predicción. */
    List<Integer> idsNeedingPrediction(Integer season) {
        List<WorldCupFixture> fixtures = WorldCupFixture
                .find("season = ?1 and homeTeam is not null and awayTeam is not null", season)
                .list();

        List<Integer> ids = new ArrayList<>();
        for (WorldCupFixture f : fixtures) {
            if (!KnockoutBracket.isKnockout(f.round) || f.apiFixtureId == null) continue;
            WorldCupPrediction existing = WorldCupPrediction.findByApiFixtureId(f.apiFixtureId);
            if (existing == null) {
                ids.add(f.apiFixtureId);
            } else if (!isFinished(f.statusShort)
                    && ChronoUnit.HOURS.between(existing.updatedAt, LocalDateTime.now()) >= STALE_HOURS) {
                ids.add(f.apiFixtureId);
            }
        }
        return ids;
    }

    void persistPrediction(Integer apiFixtureId, ApiPrediction api) {
        try {
            WorldCupPrediction p = WorldCupPrediction.findByApiFixtureId(apiFixtureId);
            if (p == null) {
                p = new WorldCupPrediction();
                p.apiFixtureId = apiFixtureId;
            }

            ApiPrediction.Predictions preds = api.predictions();
            if (preds != null) {
                p.advice = preds.advice();
                if (preds.winner() != null) {
                    p.winnerName = preds.winner().name();
                    p.winnerComment = preds.winner().comment();
                }
                if (preds.percent() != null) {
                    p.percentHome = parsePercent(preds.percent().home());
                    p.percentDraw = parsePercent(preds.percent().draw());
                    p.percentAway = parsePercent(preds.percent().away());
                    computeWinProbabilities(p);
                }
            }

            p.rawResponse = objectMapper.writeValueAsString(api);
            p.updatedAt = LocalDateTime.now();
            p.persist();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Probabilidad de AVANZAR (no hay empate en knockout): se redistribuye el % de empate
     * proporcionalmente entre ambos equipos según su peso relativo. Resultado redondeado a 1 decimal.
     */
    private void computeWinProbabilities(WorldCupPrediction p) {
        int h = p.percentHome != null ? p.percentHome : 0;
        int d = p.percentDraw != null ? p.percentDraw : 0;
        int a = p.percentAway != null ? p.percentAway : 0;
        double base = h + a;
        double winH, winA;
        if (base <= 0) {
            winH = 50.0;
            winA = 50.0;
        } else {
            winH = h + d * (h / base);
            winA = a + d * (a / base);
        }
        p.winHome = BigDecimal.valueOf(winH).setScale(1, RoundingMode.HALF_UP);
        p.winAway = BigDecimal.valueOf(winA).setScale(1, RoundingMode.HALF_UP);
    }

    private static int parsePercent(String raw) {
        if (raw == null) return 0;
        String digits = raw.replaceAll("[^0-9]", "");
        if (digits.isEmpty()) return 0;
        try {
            return Integer.parseInt(digits);
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private static boolean isFinished(String statusShort) {
        return "FT".equals(statusShort) || "AET".equals(statusShort) || "PEN".equals(statusShort);
    }

    // ---------------------------------------------------------------------------------------------
    // Armado del bracket (solo lectura de BD)
    // ---------------------------------------------------------------------------------------------

    /**
     * Construye el bracket de eliminatorias agrupado por ronda (16avos → Final). Lee solo de BD;
     * debe ejecutarse dentro de una transacción (accede a asociaciones lazy de los equipos).
     */
    @Transactional
    public List<BracketRoundDto> buildBracket(Integer season) {
        List<WorldCupFixture> fixtures = WorldCupFixture.find("season", season).list();

        // Agrupar por ronda de knockout, preservando orden de avance del torneo.
        Map<Round, List<WorldCupFixture>> byRound = new LinkedHashMap<>();
        for (Round r : Round.values()) byRound.put(r, new ArrayList<>());
        for (WorldCupFixture f : fixtures) {
            Round r = KnockoutBracket.classify(f.round);
            if (r != null) byRound.get(r).add(f);
        }

        List<BracketRoundDto> result = new ArrayList<>();
        for (Map.Entry<Round, List<WorldCupFixture>> entry : byRound.entrySet()) {
            Round round = entry.getKey();
            List<WorldCupFixture> matches = entry.getValue();
            if (matches.isEmpty()) continue;

            // Orden del bracket: por fecha (nulos al final) para emparejar hermanos de forma estable.
            matches.sort(Comparator.comparing(
                    (WorldCupFixture f) -> f.fixtureDate,
                    Comparator.nullsLast(Comparator.naturalOrder())));

            List<BracketMatchDto> dtos = new ArrayList<>();
            for (int i = 0; i < matches.size(); i++) {
                WorldCupFixture f = matches.get(i);
                List<BracketMatchDto.Team> nextOpponents = new ArrayList<>();
                if (KnockoutBracket.hasNextRound(round)) {
                    int sib = KnockoutBracket.siblingIndex(i);
                    if (sib >= 0 && sib < matches.size()) {
                        WorldCupFixture sibling = matches.get(sib);
                        addTeam(nextOpponents, sibling.homeTeam);
                        addTeam(nextOpponents, sibling.awayTeam);
                    }
                }
                dtos.add(toMatchDto(f, round, nextOpponents));
            }
            result.add(new BracketRoundDto(round.label, dtos));
        }
        return result;
    }

    private void addTeam(List<BracketMatchDto.Team> list, WorldCupTeam team) {
        if (team != null) list.add(new BracketMatchDto.Team(team.name, team.logoUrl));
    }

    private BracketMatchDto toMatchDto(WorldCupFixture f, Round round, List<BracketMatchDto.Team> nextOpponents) {
        WorldCupPrediction p = f.apiFixtureId != null
                ? WorldCupPrediction.findByApiFixtureId(f.apiFixtureId)
                : null;
        return new BracketMatchDto(
                f.apiFixtureId,
                round.label,
                f.fixtureDate,
                f.statusShort,
                f.statusLong,
                f.homeTeam != null ? new BracketMatchDto.Team(f.homeTeam.name, f.homeTeam.logoUrl) : null,
                f.awayTeam != null ? new BracketMatchDto.Team(f.awayTeam.name, f.awayTeam.logoUrl) : null,
                f.goalsHome,
                f.goalsAway,
                f.homeWinner,
                f.awayWinner,
                p != null ? p.winHome : null,
                p != null ? p.winAway : null,
                p != null ? p.advice : null,
                KnockoutBracket.hasNextRound(round),
                nextOpponents);
    }
}
