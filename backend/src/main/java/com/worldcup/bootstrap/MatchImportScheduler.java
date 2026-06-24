package com.worldcup.bootstrap;

import com.worldcup.provider.ExternalApiFootballDataProvider;
import com.worldcup.scoring.ScoringService;
import io.quarkus.scheduler.Scheduled;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.jboss.logging.Logger;

/**
 * Importa la FORMA RECIENTE real (partidos) desde la API y la PERSISTE en BD,
 * de forma periódica y en segundo plano. Así las pantallas (ranking/detalle)
 * SIEMPRE leen de la base de datos y nunca disparan llamadas a la API on-demand.
 *
 * - Cron: cada 6 horas (00:00, 06:00, 12:00, 18:00). NO se expone en la web (no on-demand).
 * - Acotado por la cuota diaria (ConfigurationService) y por la antigüedad de los datos.
 * - Si no hay API key (NO_KEY), no hace nada: la app sigue con datos simulados del arranque.
 */
@ApplicationScoped
public class MatchImportScheduler {

    private static final Logger LOG = Logger.getLogger(MatchImportScheduler.class);

    @Inject
    ExternalApiFootballDataProvider externalProvider;

    @Inject
    ScoringService scoringService;

    private volatile boolean running = false;

    @Scheduled(cron = "0 0 */6 * * ?", concurrentExecution = Scheduled.ConcurrentExecution.SKIP)
    void importRecentMatches() {
        if (running) {
            return;
        }
        try {
            running = true;
            LOG.info("Scheduler: importando forma reciente real desde la API...");
            int imported = externalProvider.refreshRecentMatches();
            if (imported > 0) {
                LOG.infof("Scheduler: %d partidos reales persistidos. Recalculando ranking...", imported);
                scoringService.recalculateAll();
            } else {
                LOG.info("Scheduler: no se importaron partidos nuevos (sin key, sin cuota o datos ya presentes).");
            }
        } catch (Exception e) {
            LOG.error("Scheduler: error importando partidos reales", e);
        } finally {
            running = false;
        }
    }
}
