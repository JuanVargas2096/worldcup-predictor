package com.worldcup.scoring;

import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Path("/api/rankings")
@Produces(MediaType.APPLICATION_JSON)
public class RankingResource {

    @Inject
    RankingService rankingService;

    @Inject
    ScoringService scoringService;

    @GET
    public List<RankingEntryDto> ranking() {
        return rankingService.ranking();
    }

    @GET
    @Path("/{teamId}")
    public TeamDetailDto detail(@PathParam("teamId") UUID teamId) {
        TeamDetailDto detail = rankingService.detailForTeam(teamId);
        if (detail == null) {
            throw new WebApplicationException("Equipo o ranking no encontrado",
                    Response.Status.NOT_FOUND);
        }
        return detail;
    }

    @POST
    @Path("/recalculate")
    public Map<String, Object> recalculate() {
        int count = scoringService.recalculateAll();
        return Map.of("recalculated", count, "message", "Ranking recalculado");
    }
}
