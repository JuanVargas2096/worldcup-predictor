package com.worldcup.match;

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
 * Resultado histórico (siempre con marcador). Alimenta el cálculo de forma.
 */
@Entity
@Table(name = "matches")
public class MatchResult extends PanacheEntityBase {

    @Id
    @GeneratedValue
    public UUID id;

    @Column(name = "match_date", nullable = false)
    public LocalDate matchDate;

    @ManyToOne(optional = false)
    @JoinColumn(name = "home_team_id")
    public Team homeTeam;

    @ManyToOne(optional = false)
    @JoinColumn(name = "away_team_id")
    public Team awayTeam;

    @Column(name = "home_score", nullable = false)
    public int homeScore;

    @Column(name = "away_score", nullable = false)
    public int awayScore;

    public String competition;

    @Column(name = "match_type")
    public String matchType;

    @Column(name = "created_at")
    public LocalDateTime createdAt = LocalDateTime.now();

    /** Últimos N partidos de un equipo (como local o visitante), por fecha desc. 
     *  Usa join fetch para evitar N+1 al obtener los nombres de los equipos. */
    public static List<MatchResult> lastMatchesForTeam(UUID teamId, int limit) {
        return find("from MatchResult m join fetch m.homeTeam join fetch m.awayTeam " +
                    "where m.homeTeam.id = ?1 or m.awayTeam.id = ?1 " +
                    "order by m.matchDate desc", teamId)
                .page(0, limit)
                .list();
    }
}
