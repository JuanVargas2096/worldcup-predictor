package com.worldcup.bootstrap;

import com.worldcup.fixture.FixtureGenerator;
import com.worldcup.match.MatchResult;
import com.worldcup.provider.FootballDataProvider;
import com.worldcup.scoring.ScoringService;
import io.quarkus.runtime.StartupEvent;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Observes;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.jboss.logging.Logger;

/**
 * Inicialización al arranque: genera el fixture de grupos, importa la forma
 * reciente si no existe y recalcula el ranking. Idempotente.
 */
@ApplicationScoped
public class DataInitializer {

    private static final Logger LOG = Logger.getLogger(DataInitializer.class);

    @Inject
    FixtureGenerator fixtureGenerator;

    @Inject
    FootballDataProvider dataProvider;

    @Inject
    ScoringService scoringService;

    @ConfigProperty(name = "worldcup.recalculate-on-start", defaultValue = "true")
    boolean recalculateOnStart;

    void onStart(@Observes StartupEvent ev) {
        LOG.info("== Inicializando datos del World Cup Predictor ==");

        try {
            int fixtures = fixtureGenerator.generateIfEmpty();
            LOG.infof("Fixtures generados: %d", fixtures);
        } catch (Exception e) {
            LOG.error("Error generando fixtures iniciales: " + e.getMessage());
        }

        // FILOSOFÍA DE TOKENS: Importación bajo demanda o inicial. 
        // Solo intentamos refrescar si hay pocos o ningún partido, 
        // para no agotar la cuota de la API externa innecesariamente.
        try {
            long matchesInDb = MatchResult.count();
            if (matchesInDb < 48) { 
                LOG.info("Pocos partidos en BD. Iniciando importación de forma reciente...");
                int imported = dataProvider.refreshRecentMatches();
                LOG.infof("Partidos recientes importados (%s): %d", dataProvider.name(), imported);
            }
        } catch (Exception e) {
            LOG.error("Error durante la importación inicial de partidos: " + e.getMessage());
        }

        if (recalculateOnStart) {
            try {
                int n = scoringService.recalculateAll();
                LOG.infof("Ranking inicial calculado para %d equipos.", n);
            } catch (Exception e) {
                LOG.error("Error calculando ranking inicial: " + e.getMessage());
            }
        }

        LOG.info("== Inicialización completada ==");
    }
}
