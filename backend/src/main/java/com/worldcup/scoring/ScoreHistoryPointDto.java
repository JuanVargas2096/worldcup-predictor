package com.worldcup.scoring;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/** Punto de la evolución del score de un equipo (para el gráfico). */
public record ScoreHistoryPointDto(
        LocalDateTime calculatedAt,
        BigDecimal finalScore,
        BigDecimal winProbability
) {
    public static ScoreHistoryPointDto from(TeamScore ts) {
        return new ScoreHistoryPointDto(ts.calculatedAt, ts.finalScore, ts.winProbability);
    }
}
