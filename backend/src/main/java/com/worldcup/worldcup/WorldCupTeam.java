package com.worldcup.worldcup;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "world_cup_team")
public class WorldCupTeam extends PanacheEntityBase {

    @Id
    @GeneratedValue
    public UUID id;

    @Column(name = "api_team_id", nullable = false, unique = true)
    public Integer apiTeamId;

    @Column(nullable = false)
    public String name;

    @Column(name = "logo_url")
    public String logoUrl;

    public String country;

    @Column(name = "created_at")
    public LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "updated_at")
    public LocalDateTime updatedAt = LocalDateTime.now();

    public static WorldCupTeam findByApiId(Integer apiTeamId) {
        return find("apiTeamId", apiTeamId).firstResult();
    }
}
