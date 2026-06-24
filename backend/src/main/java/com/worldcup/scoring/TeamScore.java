package com.worldcup.scoring;

import com.worldcup.team.Team;
import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

/** Snapshot del cálculo de un equipo. El último por equipo es el vigente. */
@Entity
@Table(name = "team_scores")
public class TeamScore extends PanacheEntityBase {

    @Id
    @GeneratedValue
    public UUID id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "team_id")
    public Team team;

    @Column(name = "calculated_at")
    public LocalDateTime calculatedAt = LocalDateTime.now();

    @Column(name = "form_score")
    public BigDecimal formScore;

    @Column(name = "goal_diff_score")
    public BigDecimal goalDiffScore;

    @Column(name = "opponent_strength_score")
    public BigDecimal opponentStrengthScore;

    @Column(name = "previous_world_cup_score")
    public BigDecimal previousWorldCupScore;

    @Column(name = "elo_score")
    public BigDecimal eloScore;

    @Column(name = "final_score")
    public BigDecimal finalScore;

    @Column(name = "win_probability")
    public BigDecimal winProbability;

    @Column(columnDefinition = "text")
    public String explanation;

    /** Último snapshot de cada equipo (vigente), ordenado por score desc. 
     *  Usa una subconsulta agrupada para mayor eficiencia. */
    public static List<TeamScore> latestRanking() {
        return getEntityManager().createQuery("""
                select ts from TeamScore ts
                join fetch ts.team
                where ts.calculatedAt in (
                    select max(ts2.calculatedAt) from TeamScore ts2 group by ts2.team
                )
                order by ts.finalScore desc
                """, TeamScore.class).getResultList();
    }

    public static List<TeamScore> historyForTeam(UUID teamId) {
        // Obtenemos los últimos 100 puntos y los re-ordenamos cronológicamente para el gráfico
        List<TeamScore> list = find("team.id = ?1 order by calculatedAt desc", teamId)
                .page(0, 100)
                .list();
        return list.stream()
                .sorted((a, b) -> a.calculatedAt.compareTo(b.calculatedAt))
                .toList();
    }

    public static TeamScore latestForTeam(UUID teamId) {
        return find("team.id = ?1 order by calculatedAt desc", teamId).firstResult();
    }
}
