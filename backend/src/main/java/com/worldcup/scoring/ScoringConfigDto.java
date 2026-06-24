package com.worldcup.scoring;

import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.util.UUID;

public record ScoringConfigDto(
        UUID id,
        @NotNull @DecimalMin("0") @DecimalMax("1") BigDecimal formWeight,
        @NotNull @DecimalMin("0") @DecimalMax("1") BigDecimal goalDiffWeight,
        @NotNull @DecimalMin("0") @DecimalMax("1") BigDecimal opponentStrengthWeight,
        @NotNull @DecimalMin("0") @DecimalMax("1") BigDecimal previousWorldCupWeight,
        @NotNull @DecimalMin("0") @DecimalMax("1") BigDecimal eloWeight
) {
    public static ScoringConfigDto from(ScoringConfig c) {
        return new ScoringConfigDto(c.id, c.formWeight, c.goalDiffWeight,
                c.opponentStrengthWeight, c.previousWorldCupWeight, c.eloWeight);
    }

    public double sum() {
        return formWeight.doubleValue() + goalDiffWeight.doubleValue()
                + opponentStrengthWeight.doubleValue() + previousWorldCupWeight.doubleValue()
                + eloWeight.doubleValue();
    }
}
