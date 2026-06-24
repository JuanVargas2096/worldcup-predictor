package com.worldcup.scoring;

import java.util.List;

/** Detalle completo de una selección (vista de detalle). */
public record TeamDetailDto(
        RankingEntryDto ranking,
        int played,
        int wins,
        int draws,
        int losses,
        int goalsFor,
        int goalsAgainst,
        int goalDiff,
        double averageOpponentStrength,
        String previousWorldCupLabel,
        List<ScoreHistoryPointDto> scoreHistory
) {}
