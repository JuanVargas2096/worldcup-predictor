package com.worldcup.team;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.math.BigDecimal;

public record TeamRequest(
        @NotBlank @Size(max = 3) String code,
        @NotBlank @Size(max = 100) String name,
        String confederation,
        Integer fifaRanking,
        BigDecimal eloRating,
        String previousWorldCupResult,
        @Size(max = 1) String groupLetter,
        Integer pot,
        String flagEmoji
) {}
