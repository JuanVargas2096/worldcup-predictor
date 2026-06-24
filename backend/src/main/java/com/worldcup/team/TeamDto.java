package com.worldcup.team;

import java.math.BigDecimal;
import java.util.UUID;

public record TeamDto(
        UUID id,
        String code,
        String name,
        String confederation,
        Integer fifaRanking,
        BigDecimal eloRating,
        String previousWorldCupResult,
        String groupLetter,
        Integer pot,
        String flagEmoji
) {
    public static TeamDto from(Team t) {
        return new TeamDto(t.id, t.code, t.name, t.confederation, t.fifaRanking,
                t.eloRating, t.previousWorldCupResult, t.groupLetter, t.pot, t.flagEmoji);
    }
}
