package com.worldcup.worldcup;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Predicción de un partido del Mundial (endpoint /predictions de API-Football), persistida DB-first.
 * Se correlaciona con {@link WorldCupFixture} por {@code apiFixtureId}.
 */
@Entity
@Table(name = "world_cup_prediction")
public class WorldCupPrediction extends PanacheEntityBase {

    @Id
    @GeneratedValue
    public UUID id;

    @Column(name = "api_fixture_id", nullable = false, unique = true)
    public Integer apiFixtureId;

    @Column(name = "percent_home")
    public Integer percentHome;

    @Column(name = "percent_draw")
    public Integer percentDraw;

    @Column(name = "percent_away")
    public Integer percentAway;

    /** Probabilidad de AVANZAR (empate redistribuido proporcionalmente). */
    @Column(name = "win_home")
    public BigDecimal winHome;

    @Column(name = "win_away")
    public BigDecimal winAway;

    @Column(name = "advice", columnDefinition = "TEXT")
    public String advice;

    @Column(name = "winner_name")
    public String winnerName;

    @Column(name = "winner_comment", columnDefinition = "TEXT")
    public String winnerComment;

    @Column(name = "raw_response", columnDefinition = "TEXT")
    public String rawResponse;

    @Column(name = "created_at")
    public LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "updated_at")
    public LocalDateTime updatedAt = LocalDateTime.now();

    public static WorldCupPrediction findByApiFixtureId(Integer apiFixtureId) {
        return find("apiFixtureId", apiFixtureId).firstResult();
    }
}
