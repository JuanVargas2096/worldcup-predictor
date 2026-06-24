package com.worldcup.worldcup;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "world_cup_fixture")
public class WorldCupFixture extends PanacheEntityBase {

    @Id
    @GeneratedValue
    public UUID id;

    @Column(name = "api_fixture_id", nullable = false, unique = true)
    public Integer apiFixtureId;

    @Column(name = "league_id")
    public Integer leagueId;

    @Column(name = "league_name")
    public String leagueName;

    public Integer season;

    public String round;

    public String referee;

    public String timezone;

    @Column(name = "fixture_date")
    public LocalDateTime fixtureDate;

    @Column(name = "fixture_timestamp")
    public Long fixtureTimestamp;

    @Column(name = "venue_id")
    public Integer venueId;

    @Column(name = "venue_name")
    public String venueName;

    @Column(name = "venue_city")
    public String venueCity;

    @Column(name = "status_long")
    public String statusLong;

    @Column(name = "status_short")
    public String statusShort;

    public Integer elapsed;

    public Integer extra;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "home_team_id")
    public WorldCupTeam homeTeam;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "away_team_id")
    public WorldCupTeam awayTeam;

    @Column(name = "home_winner")
    public Boolean homeWinner;

    @Column(name = "away_winner")
    public Boolean awayWinner;

    @Column(name = "goals_home")
    public Integer goalsHome;

    @Column(name = "goals_away")
    public Integer goalsAway;

    @Column(name = "halftime_home")
    public Integer halftimeHome;

    @Column(name = "halftime_away")
    public Integer halftimeAway;

    @Column(name = "fulltime_home")
    public Integer fulltimeHome;

    @Column(name = "fulltime_away")
    public Integer fulltimeAway;

    @Column(name = "extratime_home")
    public Integer extratimeHome;

    @Column(name = "extratime_away")
    public Integer extratimeAway;

    @Column(name = "penalty_home")
    public Integer penaltyHome;

    @Column(name = "penalty_away")
    public Integer penaltyAway;

    @Column(name = "raw_response", columnDefinition = "TEXT")
    public String rawResponse;

    @Column(name = "created_at")
    public LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "updated_at")
    public LocalDateTime updatedAt = LocalDateTime.now();

    public static WorldCupFixture findByApiId(Integer apiFixtureId) {
        return find("apiFixtureId", apiFixtureId).firstResult();
    }
}
