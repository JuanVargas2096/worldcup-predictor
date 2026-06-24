package com.worldcup.bootstrap;

import com.worldcup.scoring.ScoringService;
import io.quarkus.scheduler.Scheduled;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.jboss.logging.Logger;

/** Recalcula el ranking automáticamente una vez al día. */
@ApplicationScoped
public class RankingScheduler {

    private static final Logger LOG = Logger.getLogger(RankingScheduler.class);

    @Inject
    ScoringService scoringService;

    // Todos los días a las 06:00. Configurable vía cron si se requiere.
    @Scheduled(cron = "0 0 6 * * ?")
    void recalculateDaily() {
        LOG.info("Scheduler: recalculando ranking diario...");
        int n = scoringService.recalculateAll();
        LOG.infof("Scheduler: ranking recalculado para %d equipos.", n);
    }
}
