package com.worldcup.scoring;

import com.worldcup.match.MatchResult;
import com.worldcup.team.Team;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import org.jboss.logging.Logger;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Calcula el puntaje 0-100 de cada selección y la probabilidad de ganar el Mundial.
 * 
 * FILOSOFÍA DE TOKENS: Este servicio es 100% OFFLINE. Utiliza exclusivamente los 
 * datos de partidos y configuraciones ya persistidos en la base de datos para 
 * evitar llamadas a APIs externas durante el cálculo de ranking.
 * 
 * Detalle del modelo en contexto/04-modelo-scoring.md
 */
@ApplicationScoped
public class ScoringService {

    private static final Logger LOG = Logger.getLogger(ScoringService.class);

    /** Cantidad de partidos considerados para la forma. */
    public static final int LAST_N = 5;
    /** Temperatura del softmax de probabilidad. */
    private static final double SOFTMAX_TEMPERATURE = 12.0;

    @Inject
    ScoreExplanationBuilder explanationBuilder;

    @Inject
    RankingService rankingService;

    @Transactional
    public int recalculateAll() {
        ScoringConfig cfg = ScoringConfig.active();
        // Solo calculamos para los equipos que están en el mundial (tienen grupo)
        List<Team> teams = Team.list("groupLetter is not null");
        if (teams.isEmpty()) {
            LOG.warn("No hay equipos en fase de grupos; no se calcula ranking.");
            return 0;
        }

        List<TeamScore> snapshots = new ArrayList<>();
        for (Team team : teams) {
            // Si el equipo no tiene historial, creamos un punto inicial "base" 
            // con la fecha de ayer para que la evolución tenga al menos 2 puntos al terminar.
            if (TeamScore.count("team", team) == 0) {
                createInitialSnapshotForTeam(team, cfg);
            }

            FormStats stats = computeFormStats(team);
            TeamScore score = buildScore(team, stats, cfg);
            score.explanation = explanationBuilder.build(team, stats, score);
            snapshots.add(score);
        }

        applyWinProbabilities(snapshots);

        for (TeamScore s : snapshots) {
            s.persist();
        }
        
        // Invalidamos el cache del ranking para que el próximo acceso obtenga los datos frescos
        rankingService.refreshCache();
        
        LOG.infof("Ranking recalculado para %d equipos.", snapshots.size());
        return snapshots.size();
    }

    private void createInitialSnapshotForTeam(Team team, ScoringConfig cfg) {
        LOG.debugf("Creando snapshot inicial para %s...", team.code);
        FormStats stats = computeFormStats(team);
        TeamScore score = buildScore(team, stats, cfg);
        score.calculatedAt = LocalDateTime.now().minusDays(1);
        score.explanation = "Snapshot inicial de sistema.";
        score.winProbability = BigDecimal.ZERO; 
        score.persist();
    }

    /** Agrega los últimos N partidos de un equipo en estadísticas de forma. */
    public FormStats computeFormStats(Team team) {
        List<MatchResult> matches = MatchResult.lastMatchesForTeam(team.id, LAST_N);
        int wins = 0, draws = 0, losses = 0, gf = 0, ga = 0;
        double weightedPoints = 0;
        double opponentSum = 0;
        int opponentCount = 0;

        for (MatchResult m : matches) {
            boolean isHome = m.homeTeam.id.equals(team.id);
            int forGoals = isHome ? m.homeScore : m.awayScore;
            int againstGoals = isHome ? m.awayScore : m.homeScore;
            Team opponent = isHome ? m.awayTeam : m.homeTeam;

            gf += forGoals;
            ga += againstGoals;

            int rawPoints;
            if (forGoals > againstGoals) { wins++; rawPoints = 3; }
            else if (forGoals == againstGoals) { draws++; rawPoints = 1; }
            else { losses++; rawPoints = 0; }

            // Amistosos cuentan con menor peso (regla del enunciado).
            double typeFactor = "FRIENDLY".equalsIgnoreCase(m.matchType) ? 0.5 : 1.0;
            weightedPoints += rawPoints * typeFactor;

            opponentSum += opponentStrengthOf(opponent);
            opponentCount++;
        }

        double opponentStrength = opponentCount == 0 ? 0 : opponentSum / opponentCount;
        return new FormStats(matches.size(), wins, draws, losses, gf, ga, weightedPoints, opponentStrength);
    }

    private TeamScore buildScore(Team team, FormStats stats, ScoringConfig cfg) {
        double formScore = clamp(stats.weightedPoints() / (LAST_N * 3.0) * 100.0);
        double goalDiffScore = normalize(stats.goalDiff(), -10, 10);
        double opponentScore = clamp(stats.opponentStrength());
        double prevWcScore = WorldCupResultWeights.score0to100(team.previousWorldCupResult);
        double eloScore = normalize(team.elo(), 1300, 2100);

        double finalScore = cfg.formW() * formScore
                + cfg.goalDiffW() * goalDiffScore
                + cfg.opponentW() * opponentScore
                + cfg.prevWcW() * prevWcScore
                + cfg.eloW() * eloScore;

        TeamScore ts = new TeamScore();
        ts.team = team;
        ts.formScore = bd(formScore);
        ts.goalDiffScore = bd(goalDiffScore);
        ts.opponentStrengthScore = bd(opponentScore);
        ts.previousWorldCupScore = bd(prevWcScore);
        ts.eloScore = bd(eloScore);
        ts.finalScore = bd(finalScore);
        return ts;
    }

    /** Softmax con temperatura sobre el final_score -> probabilidad que suma 100%. */
    private void applyWinProbabilities(List<TeamScore> snapshots) {
        double sum = 0;
        double[] weights = new double[snapshots.size()];
        for (int i = 0; i < snapshots.size(); i++) {
            TeamScore score = snapshots.get(i);
            if (Boolean.TRUE.equals(score.team.isEliminated)) {
                weights[i] = 0;
            } else {
                double s = score.finalScore.doubleValue();
                weights[i] = Math.exp(s / SOFTMAX_TEMPERATURE);
                sum += weights[i];
            }
        }
        for (int i = 0; i < snapshots.size(); i++) {
            double prob = sum == 0 ? 0 : weights[i] / sum * 100.0;
            snapshots.get(i).winProbability = bd(prob);
        }
    }

    /** Fuerza 0-100 de un rival según su ranking FIFA. */
    public double opponentStrengthOf(Team opponent) {
        Integer rank = opponent.fifaRanking;
        if (rank == null) return 35;
        if (rank <= 5) return 100;
        if (rank <= 10) return 90;
        if (rank <= 20) return 75;
        if (rank <= 50) return 55;
        return 35;
    }

    public static double normalize(double value, double min, double max) {
        return clamp((value - min) / (max - min) * 100.0);
    }

    private static double clamp(double v) {
        return Math.max(0, Math.min(100, v));
    }

    private static BigDecimal bd(double v) {
        return BigDecimal.valueOf(v).setScale(2, RoundingMode.HALF_UP);
    }

    public FormStats statsForTeam(UUID teamId) {
        Team team = Team.findById(teamId);
        return team == null ? null : computeFormStats(team);
    }
}
