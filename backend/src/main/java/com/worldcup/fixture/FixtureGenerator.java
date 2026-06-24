package com.worldcup.fixture;

import com.worldcup.team.Team;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;
import org.jboss.logging.Logger;

import java.time.LocalDate;
import java.util.List;

/**
 * Genera el calendario round-robin de la fase de grupos a partir de los equipos
 * reales de cada grupo (A-L). 3 jornadas, 6 partidos por grupo.
 *
 * Las fechas/sedes son aproximadas (ventana real: 11-27 jun 2026); el calendario
 * oficial puede sustituirse sin cambiar el modelo. Ver contexto/07.
 */
@ApplicationScoped
public class FixtureGenerator {

    private static final Logger LOG = Logger.getLogger(FixtureGenerator.class);
    private static final String[] GROUPS = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"};
    private static final LocalDate KICKOFF = LocalDate.of(2026, 6, 11);
    private static final String[] VENUES = {
            "MetLife Stadium (Nueva York)", "SoFi Stadium (Los Ángeles)",
            "AT&T Stadium (Dallas)", "Estadio Azteca (Ciudad de México)",
            "BMO Field (Toronto)", "Mercedes-Benz Stadium (Atlanta)"
    };

    @Transactional
    public int generateIfEmpty() {
        if (Fixture.count() > 0) {
            return 0;
        }
        int created = 0;
        for (int g = 0; g < GROUPS.length; g++) {
            String letter = GROUPS[g];
            List<Team> teams = Team.list("groupLetter = ?1 order by pot asc", letter);
            if (teams.size() != 4) {
                LOG.warnf("Grupo %s tiene %d equipos (se esperaban 4); se omite.", letter, teams.size());
                continue;
            }
            created += createGroupFixtures(letter, teams, g);
        }
        LOG.infof("FixtureGenerator creó %d partidos de fase de grupos.", created);
        return created;
    }

    private int createGroupFixtures(String letter, List<Team> t, int groupIndex) {
        // Método del círculo para 4 equipos -> 3 jornadas de 2 partidos.
        int[][][] schedule = {
                {{0, 3}, {1, 2}}, // jornada 1
                {{0, 2}, {3, 1}}, // jornada 2
                {{0, 1}, {2, 3}}  // jornada 3
        };
        int created = 0;
        for (int md = 0; md < schedule.length; md++) {
            LocalDate date = KICKOFF.plusDays(md * 5L + (groupIndex % 5));
            for (int[] pair : schedule[md]) {
                Fixture f = new Fixture();
                f.groupLetter = letter;
                f.matchday = md + 1;
                f.scheduledDate = date;
                f.venue = VENUES[(groupIndex + md) % VENUES.length];
                f.homeTeam = t.get(pair[0]);
                f.awayTeam = t.get(pair[1]);
                f.persist();
                created++;
            }
        }
        return created;
    }
}
