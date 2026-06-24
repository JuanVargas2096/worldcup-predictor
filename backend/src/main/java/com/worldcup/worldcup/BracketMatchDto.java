package com.worldcup.worldcup;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Un partido de eliminatoria para la vista de bracket: equipos, marcador/estado,
 * % de avanzar de cada equipo (predicción) y los posibles rivales de la siguiente fase.
 */
public record BracketMatchDto(
        Integer apiFixtureId,
        String round,
        LocalDateTime fixtureDate,
        String statusShort,
        String statusLong,
        Team home,
        Team away,
        Integer goalsHome,
        Integer goalsAway,
        /** Quién avanzó (incluye desempate por penales, según la API). */
        Boolean homeWinner,
        Boolean awayWinner,
        BigDecimal winProbHome,
        BigDecimal winProbAway,
        String advice,
        /** True si esta ronda tiene fase siguiente (la final y el 3er puesto no). */
        boolean hasNextRound,
        /** 0–2 equipos: los posibles rivales de la siguiente fase (vacío = "Por definir"). */
        List<Team> nextOpponents
) {
    public record Team(String name, String logo) {}
}
