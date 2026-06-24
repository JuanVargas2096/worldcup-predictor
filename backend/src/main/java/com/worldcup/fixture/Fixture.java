package com.worldcup.fixture;

import com.worldcup.team.Team;
import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

/**
 * Partido del calendario de la fase de grupos del Mundial 2026.
 * El marcador puede ser null (aún no jugado).
 */
@Entity
@Table(name = "fixtures")
public class Fixture extends PanacheEntityBase {

    @Id
    @GeneratedValue
    public UUID id;

    @Column(name = "group_letter", nullable = false, length = 1)
    public String groupLetter;

    @Column(nullable = false)
    public int matchday;

    @Column(name = "scheduled_date")
    public LocalDate scheduledDate;

    public String venue;

    @ManyToOne(optional = false)
    @JoinColumn(name = "home_team_id")
    public Team homeTeam;

    @ManyToOne(optional = false)
    @JoinColumn(name = "away_team_id")
    public Team awayTeam;

    @Column(name = "home_score")
    public Integer homeScore;

    @Column(name = "away_score")
    public Integer awayScore;

    @Column(name = "created_at")
    public LocalDateTime createdAt = LocalDateTime.now();

    public static List<Fixture> allOrdered() {
        return list("order by groupLetter asc, matchday asc, scheduledDate asc");
    }

    public static List<Fixture> byGroup(String groupLetter) {
        return list("groupLetter = ?1 order by matchday asc, scheduledDate asc", groupLetter);
    }
}
