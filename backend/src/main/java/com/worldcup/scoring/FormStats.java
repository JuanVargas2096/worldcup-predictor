package com.worldcup.scoring;

/** Estadísticas agregadas de los últimos partidos de un equipo. */
public record FormStats(
        int played,
        int wins,
        int draws,
        int losses,
        int goalsFor,
        int goalsAgainst,
        double weightedPoints,   // puntos de forma (amistosos cuentan x0.5)
        double opponentStrength  // promedio 0-100 de fuerza de rivales
) {
    public int goalDiff() {
        return goalsFor - goalsAgainst;
    }
}
