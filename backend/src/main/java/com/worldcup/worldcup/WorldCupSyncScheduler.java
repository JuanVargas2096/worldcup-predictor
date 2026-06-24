package com.worldcup.worldcup;

import com.worldcup.config.AppParameter;
import io.quarkus.scheduler.Scheduled;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import org.jboss.logging.Logger;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

@ApplicationScoped
public class WorldCupSyncScheduler {

    private static final Logger LOG = Logger.getLogger(WorldCupSyncScheduler.class);

    @Inject
    WorldCupSyncService syncService;

    private boolean isRunning = false;

    @Scheduled(every = "10m")
    @Transactional
    public void checkAndSync() {
        if (isRunning) {
            LOG.debug("La sincronización ya está en ejecución en otro hilo o instancia. Saltando...");
            return;
        }

        String nStr = AppParameter.getValue("WORLD_CUP_SYNC_RUNS_PER_DAY", "6");
        int n;
        try {
            n = Integer.parseInt(nStr);
        } catch (NumberFormatException e) {
            LOG.warnf("Valor inválido para WORLD_CUP_SYNC_RUNS_PER_DAY: %s. Usando default 6.", nStr);
            n = 6;
        }

        if (n <= 0) {
            LOG.debug("Sincronización automática desactivada (N <= 0).");
            return;
        }

        if (n > 24) n = 24;

        long intervalHours = 24 / n;
        
        AppParameter lastSyncParam = AppParameter.findByKey("WORLD_CUP_LAST_SYNC");
        LocalDateTime lastSync = null;
        if (lastSyncParam != null && lastSyncParam.value != null) {
            try {
                lastSync = LocalDateTime.parse(lastSyncParam.value);
            } catch (Exception e) {
                LOG.warn("Error parseando WORLD_CUP_LAST_SYNC, se ignorará.");
            }
        }

        if (lastSync == null || ChronoUnit.HOURS.between(lastSync, LocalDateTime.now()) >= intervalHours) {
            try {
                isRunning = true;
                LOG.infof("Ejecutando sincronización programada (Intervalo: %d horas)...", intervalHours);
                
                // League 1 = World Cup, Season 2026
                syncService.syncWorldCup(1, 2026);
                
                // Actualizar última ejecución en BD
                if (lastSyncParam == null) {
                    lastSyncParam = new AppParameter();
                    lastSyncParam.key = "WORLD_CUP_LAST_SYNC";
                    lastSyncParam.description = "Fecha de la última sincronización automática exitosa";
                }
                lastSyncParam.value = LocalDateTime.now().toString();
                lastSyncParam.updatedAt = LocalDateTime.now();
                lastSyncParam.persist();
                
            } catch (Exception e) {
                LOG.error("Error durante la sincronización programada", e);
            } finally {
                isRunning = false;
            }
        }
    }
}
