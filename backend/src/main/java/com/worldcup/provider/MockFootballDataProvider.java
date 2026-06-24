package com.worldcup.provider;

import com.worldcup.match.MatchResult;
import com.worldcup.team.Team;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Typed;
import jakarta.transaction.Transactional;
import org.jboss.logging.Logger;

import java.time.LocalDate;
import java.util.List;
import java.util.Random;

/**
 * Proveedor de datos sintéticos para el MVP. Genera forma reciente realista:
 * cada selección juega partidos contra otras clasificadas y el marcador se
 * simula a partir de la diferencia de ELO (los más fuertes ganan más a menudo).
 *
 * Los EQUIPOS y GRUPOS son reales (sembrados por Flyway). Solo los resultados
 * recientes son sintéticos. Sustituible por ExternalApiFootballDataProvider.
 */
@ApplicationScoped
@Typed(MockFootballDataProvider.class)
public class MockFootballDataProvider implements FootballDataProvider {

    private static final Logger LOG = Logger.getLogger(MockFootballDataProvider.class);
    private static final int MATCHES_PER_TEAM = 6;
    private static final String[] COMPETITIONS = {
            "Eliminatorias", "Amistoso", "UEFA Nations League", "Copa Continental"
    };
    private static final String[] TYPES = {
            "QUALIFIER", "FRIENDLY", "NATIONS_LEAGUE", "CONTINENTAL"
    };

    @Override
    public String name() {
        return "mock";
    }

    @Override
    @Transactional
    public int refreshRecentMatches() {
        MatchResult.deleteAll();
        List<Team> teams = Team.listAll();
        if (teams.size() < 2) {
            return 0;
        }

        int created = 0;
        for (Team team : teams) {
            // Random determinista por equipo -> resultados reproducibles.
            Random rnd = new Random(team.code.hashCode() * 31L + 7);
            for (int i = 0; i < MATCHES_PER_TEAM; i++) {
                Team opponent = pickOpponent(teams, team, rnd);
                LocalDate date = LocalDate.now().minusDays(20L * (i + 1) + rnd.nextInt(10));
                int typeIdx = rnd.nextInt(TYPES.length);

                int[] score = simulateScore(team.elo(), opponent.elo(), rnd);

                MatchResult m = new MatchResult();
                m.matchDate = date;
                m.homeTeam = team;
                m.awayTeam = opponent;
                m.homeScore = score[0];
                m.awayScore = score[1];
                m.competition = COMPETITIONS[typeIdx] + " (simulado)";
                // Marca 'MOCK' para que la importación real (EXTERNAL) pueda reemplazarlos.
                m.matchType = "MOCK";
                m.persist();
                created++;
            }
        }
        LOG.infof("MockFootballDataProvider generó %d partidos recientes.", created);
        return created;
    }

    private Team pickOpponent(List<Team> teams, Team team, Random rnd) {
        Team opp;
        do {
            opp = teams.get(rnd.nextInt(teams.size()));
        } while (opp.id.equals(team.id));
        return opp;
    }

    /** Simula un marcador a partir de la diferencia de ELO (ventaja local incluida). */
    private int[] simulateScore(double homeElo, double awayElo, Random rnd) {
        double diff = (homeElo + 60) - awayElo; // +60 ventaja de localía
        double lambdaHome = clamp(1.35 + diff / 350.0, 0.25, 4.0);
        double lambdaAway = clamp(1.35 - diff / 350.0, 0.25, 4.0);
        return new int[]{poisson(lambdaHome, rnd), poisson(lambdaAway, rnd)};
    }

    /** Muestreo Poisson (algoritmo de Knuth). */
    private int poisson(double lambda, Random rnd) {
        double l = Math.exp(-lambda);
        int k = 0;
        double p = 1.0;
        do {
            k++;
            p *= rnd.nextDouble();
        } while (p > l);
        return Math.min(k - 1, 7);
    }

    private double clamp(double v, double min, double max) {
        return Math.max(min, Math.min(max, v));
    }
}
