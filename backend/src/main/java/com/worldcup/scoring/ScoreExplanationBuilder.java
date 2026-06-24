package com.worldcup.scoring;

import com.worldcup.team.Team;
import jakarta.enterprise.context.ApplicationScoped;

/** Construye una explicación textual del puntaje para mostrar transparencia. */
@ApplicationScoped
public class ScoreExplanationBuilder {

    public String build(Team team, FormStats stats, TeamScore score) {
        StringBuilder sb = new StringBuilder();
        sb.append(team.name)
          .append(" obtiene ").append(score.finalScore.doubleValue())
          .append("/100. ");

        // Forma
        sb.append("Forma reciente: ")
          .append(stats.wins()).append("V-")
          .append(stats.draws()).append("E-")
          .append(stats.losses()).append("D en ")
          .append(stats.played()).append(" partidos (")
          .append(score.formScore.doubleValue()).append(" pts). ");

        // Goles
        int gd = stats.goalDiff();
        sb.append("Diferencia de goles ")
          .append(gd >= 0 ? "+" : "").append(gd)
          .append(" (").append(stats.goalsFor()).append(" a favor, ")
          .append(stats.goalsAgainst()).append(" en contra). ");

        // Rivales
        sb.append("Fuerza media de rivales ")
          .append(round(stats.opponentStrength())).append("/100");
        if (stats.opponentStrength() >= 75) sb.append(" (rivales de élite). ");
        else if (stats.opponentStrength() >= 55) sb.append(" (rivales sólidos). ");
        else sb.append(" (rivales accesibles). ");

        // Mundial anterior
        sb.append(WorldCupResultWeights.label(team.previousWorldCupResult));
        int bonus = WorldCupResultWeights.rawBonus(team.previousWorldCupResult);
        if (bonus != 0) {
            sb.append(" (").append(bonus > 0 ? "+" : "").append(bonus).append(" exp.)");
        }
        sb.append(". ");

        // ELO
        sb.append("ELO histórico ").append((int) team.elo()).append(".");

        return sb.toString();
    }

    private double round(double v) {
        return Math.round(v * 10.0) / 10.0;
    }
}
