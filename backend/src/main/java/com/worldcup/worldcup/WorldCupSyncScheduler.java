package com.worldcup.worldcup;

import com.worldcup.config.AppParameter;
import io.quarkus.narayana.jta.QuarkusTransaction;
import io.quarkus.scheduler.Scheduled;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.jboss.logging.Logger;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

/**
 * Sincroniza el Mundial hasta N veces/día (WORLD_CUP_SYNC_RUNS_PER_DAY, default 6),
 * repartido por intervalos de 24/N horas.
 *
 * El método NO es @Transactional: la sincronización hace HTTP (ver
 * {@link WorldCupSyncService}) y no debe retener una conexión de BD. Las lecturas
 * y escrituras de parámetros usan transacciones cortas con {@link QuarkusTransaction}.
 */
@ApplicationScoped
public class WorldCupSyncScheduler {

    private static final Logger LOG = Logger.getLogger(WorldCupSyncScheduler.class);

    @Inject
    WorldCupSyncService syncService;

    @Inject
    WorldCupPredictionService predictionService;

    private volatile boolean isRunning = false;

    @Scheduled(every = "10m")
    void checkAndSync() {
        if (isRunning) {
            LOG.debug("Sincronización ya en ejecución. Saltando...");
            return;
        }

        int n = parseRunsPerDay(QuarkusTransaction.requiringNew()
                .call(() -> AppParameter.getValue("WORLD_CUP_SYNC_RUNS_PER_DAY", "6")));
        if (n <= 0) {
            LOG.debug("Sincronización automática desactivada (N <= 0).");
            return;
        }
        if (n > 24) n = 24;
        long intervalHours = 24 / n;

        LocalDateTime lastSync = QuarkusTransaction.requiringNew().call(() -> {
            AppParameter p = AppParameter.findByKey("WORLD_CUP_LAST_SYNC");
            if (p == null || p.value == null) return null;
            try {
                return LocalDateTime.parse(p.value);
            } catch (Exception e) {
                LOG.warn("Error parseando WORLD_CUP_LAST_SYNC, se ignorará.");
                return null;
            }
        });

        if (lastSync != null && ChronoUnit.HOURS.between(lastSync, LocalDateTime.now()) < intervalHours) {
            return; // aún no toca
        }

        try {
            isRunning = true;
            LOG.infof("Ejecutando sincronización programada (intervalo: %d h)...", intervalHours);
            syncService.syncWorldCup(1, 2026); // gestiona su propio HTTP + transacciones cortas
            // Tras sincronizar fixtures, refrescar predicciones de los partidos de eliminatoria
            // ya definidos (HTTP fuera de tx, acotado por la cuota diaria de la API).
            predictionService.refreshPredictions(2026);
            QuarkusTransaction.requiringNew().run(() -> {
                AppParameter p = AppParameter.findByKey("WORLD_CUP_LAST_SYNC");
                if (p == null) {
                    p = new AppParameter();
                    p.key = "WORLD_CUP_LAST_SYNC";
                    p.description = "Fecha de la última sincronización automática";
                }
                p.value = LocalDateTime.now().toString();
                p.updatedAt = LocalDateTime.now();
                p.persist();
            });
        } catch (Exception e) {
            LOG.error("Error durante la sincronización programada", e);
        } finally {
            isRunning = false;
        }
    }

    private int parseRunsPerDay(String value) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            LOG.warnf("Valor inválido para WORLD_CUP_SYNC_RUNS_PER_DAY: %s. Usando 6.", value);
            return 6;
        }
    }
}
