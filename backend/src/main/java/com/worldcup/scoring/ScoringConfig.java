package com.worldcup.scoring;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

/** Pesos del modelo. Solo una fila con active = true rige el cálculo. */
@Entity
@Table(name = "scoring_config")
public class ScoringConfig extends PanacheEntityBase {

    @Id
    @GeneratedValue
    public UUID id;

    @Column(name = "form_weight", nullable = false)
    public BigDecimal formWeight = BigDecimal.valueOf(0.40);

    @Column(name = "goal_diff_weight", nullable = false)
    public BigDecimal goalDiffWeight = BigDecimal.valueOf(0.20);

    @Column(name = "opponent_strength_weight", nullable = false)
    public BigDecimal opponentStrengthWeight = BigDecimal.valueOf(0.15);

    @Column(name = "previous_world_cup_weight", nullable = false)
    public BigDecimal previousWorldCupWeight = BigDecimal.valueOf(0.15);

    @Column(name = "elo_weight", nullable = false)
    public BigDecimal eloWeight = BigDecimal.valueOf(0.10);

    @Column(nullable = false)
    public boolean active = true;

    @Column(name = "created_at")
    public LocalDateTime createdAt = LocalDateTime.now();

    public static ScoringConfig active() {
        ScoringConfig cfg = find("active = true order by createdAt desc").firstResult();
        return cfg != null ? cfg : new ScoringConfig();
    }

    public double formW() { return formWeight.doubleValue(); }
    public double goalDiffW() { return goalDiffWeight.doubleValue(); }
    public double opponentW() { return opponentStrengthWeight.doubleValue(); }
    public double prevWcW() { return previousWorldCupWeight.doubleValue(); }
    public double eloW() { return eloWeight.doubleValue(); }
}
