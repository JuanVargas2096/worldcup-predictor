package com.worldcup.match;

import java.time.LocalDate;
import java.util.UUID;

public record MatchDto(
        UUID id,
        LocalDate matchDate,
        UUID homeTeamId,
        String homeTeamCode,
        String homeTeamName,
        UUID awayTeamId,
        String awayTeamCode,
        String awayTeamName,
        int homeScore,
        int awayScore,
        String competition,
        String matchType
) {
    public static MatchDto from(MatchResult m) {
        return new MatchDto(
                m.id, m.matchDate,
                m.homeTeam.id, m.homeTeam.code, m.homeTeam.name,
                m.awayTeam.id, m.awayTeam.code, m.awayTeam.name,
                m.homeScore, m.awayScore, m.competition, m.matchType);
    }
}
