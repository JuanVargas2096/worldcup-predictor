package com.worldcup.team;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "teams")
public class Team extends PanacheEntityBase {

    @Id
    @GeneratedValue
    public UUID id;

    @Column(nullable = false, unique = true, length = 3)
    public String code;

    @Column(nullable = false)
    public String name;

    public String confederation;

    @Column(name = "fifa_ranking")
    public Integer fifaRanking;

    @Column(name = "elo_rating")
    public BigDecimal eloRating;

    @Column(name = "previous_world_cup_result")
    public String previousWorldCupResult;

    @Column(name = "group_letter", length = 1)
    public String groupLetter;

    public Integer pot;

    @Column(name = "flag_emoji")
    public String flagEmoji;

    @Column(name = "created_at")
    public LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "updated_at")
    public LocalDateTime updatedAt = LocalDateTime.now();

    public static Team findByCode(String code) {
        return find("code", code).firstResult();
    }

    public static List<Team> listAllOrdered() {
        return list("order by fifaRanking asc nulls last");
    }

    public double elo() {
        return eloRating == null ? 1500.0 : eloRating.doubleValue();
    }
}
