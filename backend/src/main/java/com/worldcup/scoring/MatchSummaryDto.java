package com.worldcup.scoring;

import com.worldcup.match.MatchResult;
import com.worldcup.team.Team;

import java.time.LocalDate;

/** Resumen de un partido desde la perspectiva de un equipo. */
public record MatchSummaryDto(
        LocalDate date,
        String result,        // W / D / L
        int goalsFor,
        int goalsAgainst,
        String opponentCode,
        String opponentName,
        String opponentFlag,
        String competition,
        String matchType
) {
    public static MatchSummaryDto from(MatchResult m, Team team) {
        boolean isHome = m.homeTeam.id.equals(team.id);
        int gf = isHome ? m.homeScore : m.awayScore;
        int ga = isHome ? m.awayScore : m.homeScore;
        Team opp = isHome ? m.awayTeam : m.homeTeam;
        String result = gf > ga ? "W" : (gf == ga ? "D" : "L");
        return new MatchSummaryDto(m.matchDate, result, gf, ga,
                opp.code, opp.name, opp.flagEmoji, m.competition, m.matchType);
    }
}
