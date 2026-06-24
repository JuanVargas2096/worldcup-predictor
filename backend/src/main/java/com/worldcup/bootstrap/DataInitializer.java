package com.worldcup.bootstrap;

import com.worldcup.config.ConfigurationService;
import com.worldcup.fixture.FixtureGenerator;
import com.worldcup.match.MatchResult;
import com.worldcup.provider.FootballDataProvider;
import com.worldcup.scoring.ScoringService;
import io.quarkus.narayana.jta.QuarkusTransaction;
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

    @Inject
    ConfigurationService configurationService;

    @ConfigProperty(name = "worldcup.recalculate-on-start", defaultValue = "true")
    boolean recalculateOnStart;

    void onStart(@Observes StartupEvent ev) {
        LOG.info("== Inicializando datos del World Cup Predictor ==");

        // Bootstrap de la API key: si la BD aún no la tiene pero hay variable de entorno, se siembra
        // una sola vez. A partir de ahí la fuente de verdad es la BD (configuration.FOOTBALL_API_KEY)
        // y la variable de entorno puede retirarse.
        try {
            // Origen "env" = la BD aún no tiene key válida pero la variable de entorno sí → sembrarla.
            if ("env".equals(configurationService.getApiKeySource())) {
                configurationService.getEnvApiKey().ifPresent(envKey -> {
                    configurationService.setApiKey(envKey);
                    LOG.info("API key sembrada en BD desde la variable de entorno (bootstrap inicial).");
                });
            }
        } catch (Exception e) {
            LOG.error("Error sembrando la API key en BD: " + e.getMessage());
        }

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
            // count() necesita una sesion activa: lo ejecutamos en su propia transaccion corta.
            // OJO: usar lambda, NO referencia a método (MatchResult::count): Panache reescribe
            // las llamadas invokestatic pero no las method-references, y fallaría con
            // "did you forget to annotate your entity with @Entity?".
            long matchesInDb = QuarkusTransaction.requiringNew().call(() -> MatchResult.count());
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
