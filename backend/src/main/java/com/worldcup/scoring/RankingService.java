package com.worldcup.scoring;

import com.worldcup.match.MatchResult;
import com.worldcup.team.Team;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.UUID;

/** Ensambla los DTOs de ranking y detalle a partir de los snapshots de score. */
@ApplicationScoped
public class RankingService {

    private static final Logger log = LoggerFactory.getLogger(RankingService.class);
    @Inject
    ScoringService scoringService;

    private static final long CACHE_TTL_MS = 60_000;
    private volatile List<TeamScore> cachedRanking;
    private volatile long lastUpdateMillis;

    public List<RankingEntryDto> ranking() {
        List<TeamScore> scores = getLatestRanking();
        int[] pos = {0};
        return scores.stream().map(ts -> toEntry(++pos[0], ts)).toList();
    }

    /**
     * Ranking actual con cache de 1 min. SIN bloqueo global: una recarga lenta no
     * serializa al resto de peticiones (evita que el detalle "se quede cargando").
     */
    private List<TeamScore> getLatestRanking() {
        List<TeamScore> cache = cachedRanking;
        if (cache == null || System.currentTimeMillis() - lastUpdateMillis > CACHE_TTL_MS) {
            cache = TeamScore.latestRanking();
            cachedRanking = cache;
            lastUpdateMillis = System.currentTimeMillis();
        }
        return cache;
    }

    public void refreshCache() {
        cachedRanking = TeamScore.latestRanking();
        lastUpdateMillis = System.currentTimeMillis();
    }

    public RankingEntryDto entryForTeam(UUID teamId) {
        List<TeamScore> currentRanking = getLatestRanking();
        int position = 0;
        TeamScore latest = null;

        for (int i = 0; i < currentRanking.size(); i++) {
            TeamScore ts = currentRanking.get(i);
            if (ts.team.id.equals(teamId)) {
                position = i + 1;
                latest = ts;
                break;
            }
        }

        if (latest == null) return null;
        return toEntry(position, latest);
    }

    public TeamDetailDto detailForTeam(UUID teamId) {
        log.info("Obteniendo detalle para equipo [{}]", teamId);
        RankingEntryDto entry = entryForTeam(teamId);
        if (entry == null) {
            log.info("[return]");
            return null;
        }

        log.info("Obteniendo detalle para equipo [{}]", teamId);
        Team team = Team.findById(teamId);
        if (team == null) return null;

        FormStats stats = scoringService.computeFormStats(team);
        List<ScoreHistoryPointDto> history = TeamScore.historyForTeam(teamId)
                .stream().map(ScoreHistoryPointDto::from).toList();

        return new TeamDetailDto(
                entry,
                stats.played(), stats.wins(), stats.draws(), stats.losses(),
                stats.goalsFor(), stats.goalsAgainst(), stats.goalDiff(),
                Math.round(stats.opponentStrength() * 10.0) / 10.0,
                WorldCupResultWeights.label(team.previousWorldCupResult),
                history);
    }

    private RankingEntryDto toEntry(int position, TeamScore ts) {
        Team team = ts.team;
        List<MatchSummaryDto> lastFive = MatchResult.lastMatchesForTeam(team.id, 5)
                .stream().map(m -> MatchSummaryDto.from(m, team)).toList();
        return new RankingEntryDto(
                position, team.id, team.code, team.name, team.flagEmoji,
                team.confederation, team.groupLetter,
                ts.finalScore, ts.winProbability,
                ts.formScore, ts.goalDiffScore, ts.opponentStrengthScore,
                ts.previousWorldCupScore, ts.eloScore,
                lastFive, ts.explanation,
                Boolean.TRUE.equals(team.isEliminated));
    }
}
