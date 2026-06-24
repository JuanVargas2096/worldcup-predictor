package com.worldcup.scoring;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

/** Una fila del ranking de favoritos. */
public record RankingEntryDto(
        int position,
        UUID teamId,
        String code,
        String name,
        String flagEmoji,
        String confederation,
        String groupLetter,
        BigDecimal finalScore,
        BigDecimal winProbability,
        BigDecimal formScore,
        BigDecimal goalDiffScore,
        BigDecimal opponentStrengthScore,
        BigDecimal previousWorldCupScore,
        BigDecimal eloScore,
        List<MatchSummaryDto> lastFive,
        String explanation
) {}
