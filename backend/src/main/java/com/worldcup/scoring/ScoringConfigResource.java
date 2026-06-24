package com.worldcup.scoring;

import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("/api/scoring-config")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ScoringConfigResource {

    @Inject
    ScoringService scoringService;

    @GET
    public ScoringConfigDto get() {
        return ScoringConfigDto.from(ScoringConfig.active());
    }

    /**
     * Actualiza los pesos. La suma debe ser 1.0 (±0.001). Crea una nueva fila
     * activa y desactiva las anteriores; luego recalcula el ranking.
     */
    @PUT
    @Transactional
    public ScoringConfigDto update(@Valid ScoringConfigDto dto) {
        double sum = dto.sum();
        if (Math.abs(sum - 1.0) > 0.001) {
            throw new WebApplicationException(
                    "La suma de los pesos debe ser 100% (1.0). Suma actual: " + sum,
                    Response.Status.BAD_REQUEST);
        }

        ScoringConfig.update("active = false where active = true");

        ScoringConfig cfg = new ScoringConfig();
        cfg.formWeight = dto.formWeight();
        cfg.goalDiffWeight = dto.goalDiffWeight();
        cfg.opponentStrengthWeight = dto.opponentStrengthWeight();
        cfg.previousWorldCupWeight = dto.previousWorldCupWeight();
        cfg.eloWeight = dto.eloWeight();
        cfg.active = true;
        cfg.persist();

        scoringService.recalculateAll();
        return ScoringConfigDto.from(cfg);
    }
}
