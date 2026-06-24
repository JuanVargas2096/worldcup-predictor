package com.worldcup.fixture;

import java.time.LocalDate;
import java.util.UUID;

public record FixtureDto(
        UUID id,
        String groupLetter,
        int matchday,
        LocalDate scheduledDate,
        String venue,
        UUID homeTeamId,
        String homeTeamName,
        String homeTeamCode,
        String homeFlag,
        UUID awayTeamId,
        String awayTeamName,
        String awayTeamCode,
        String awayFlag,
        Integer homeScore,
        Integer awayScore,
        boolean played
) {
    public static FixtureDto from(Fixture f) {
        boolean played = f.homeScore != null && f.awayScore != null;
        return new FixtureDto(
                f.id, f.groupLetter, f.matchday, f.scheduledDate, f.venue,
                f.homeTeam.id, f.homeTeam.name, f.homeTeam.code, f.homeTeam.flagEmoji,
                f.awayTeam.id, f.awayTeam.name, f.awayTeam.code, f.awayTeam.flagEmoji,
                f.homeScore, f.awayScore, played);
    }
}
