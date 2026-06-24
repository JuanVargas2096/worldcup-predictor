package com.worldcup.scoring;

import com.worldcup.match.MatchResult;
import com.worldcup.team.Team;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.List;
import java.util.UUID;

/** Ensambla los DTOs de ranking y detalle a partir de los snapshots de score. */
@ApplicationScoped
public class RankingService {

    @Inject
    ScoringService scoringService;

    public List<RankingEntryDto> ranking() {
        List<TeamScore> scores = TeamScore.latestRanking();
        int[] pos = {0};
        return scores.stream().map(ts -> toEntry(++pos[0], ts)).toList();
    }

    public RankingEntryDto entryForTeam(UUID teamId) {
        List<RankingEntryDto> all = ranking();
        return all.stream().filter(e -> e.teamId().equals(teamId)).findFirst().orElse(null);
    }

    public TeamDetailDto detailForTeam(UUID teamId) {
        Team team = Team.findById(teamId);
        if (team == null) return null;
        RankingEntryDto entry = entryForTeam(teamId);
        if (entry == null) return null;

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
                lastFive, ts.explanation);
    }
}
