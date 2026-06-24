package com.worldcup.scoring;

import com.worldcup.match.MatchResult;
import com.worldcup.team.Team;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

/** Ensambla los DTOs de ranking y detalle a partir de los snapshots de score. */
@ApplicationScoped
public class RankingService {

    @Inject
    ScoringService scoringService;

    private List<TeamScore> cachedRanking;
    private LocalDateTime lastUpdate;

    public List<RankingEntryDto> ranking() {
        List<TeamScore> scores = getLatestRanking();
        int[] pos = {0};
        return scores.stream().map(ts -> toEntry(++pos[0], ts)).toList();
    }

    /** Obtiene el ranking actual, usando cache por 1 minuto para evitar latencias. */
    private synchronized List<TeamScore> getLatestRanking() {
        if (cachedRanking == null || lastUpdate == null || lastUpdate.isBefore(LocalDateTime.now().minusMinutes(1))) {
            refreshCache();
        }
        return cachedRanking;
    }

    public synchronized void refreshCache() {
        cachedRanking = TeamScore.latestRanking();
        lastUpdate = LocalDateTime.now();
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
        RankingEntryDto entry = entryForTeam(teamId);
        if (entry == null) return null;
        
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
