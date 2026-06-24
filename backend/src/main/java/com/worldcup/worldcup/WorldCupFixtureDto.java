package com.worldcup.worldcup;

import java.time.LocalDateTime;
import java.util.UUID;

/** Vista ligera de un partido real sincronizado del Mundial (para el SPA). */
public record WorldCupFixtureDto(
        UUID id,
        Integer apiFixtureId,
        String leagueName,
        Integer season,
        String round,
        LocalDateTime fixtureDate,
        String venueName,
        String venueCity,
        String statusShort,
        String statusLong,
        Integer elapsed,
        String homeTeamName,
        String homeTeamLogo,
        Boolean homeWinner,
        Integer goalsHome,
        String awayTeamName,
        String awayTeamLogo,
        Boolean awayWinner,
        Integer goalsAway
) {
    public static WorldCupFixtureDto from(WorldCupFixture f) {
        return new WorldCupFixtureDto(
                f.id, f.apiFixtureId, f.leagueName, f.season, f.round, f.fixtureDate,
                f.venueName, f.venueCity, f.statusShort, f.statusLong, f.elapsed,
                f.homeTeam != null ? f.homeTeam.name : null,
                f.homeTeam != null ? f.homeTeam.logoUrl : null,
                f.homeWinner, f.goalsHome,
                f.awayTeam != null ? f.awayTeam.name : null,
                f.awayTeam != null ? f.awayTeam.logoUrl : null,
                f.awayWinner, f.goalsAway);
    }
}
