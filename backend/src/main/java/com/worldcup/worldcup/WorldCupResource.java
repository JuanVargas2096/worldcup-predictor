package com.worldcup.worldcup;

import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Path("/api/world-cup")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class WorldCupResource {

    @Inject
    WorldCupSyncService syncService;

    @POST
    @Path("/sync")
    public SyncResult manualSync(
            @QueryParam("league") Integer league,
            @QueryParam("season") Integer season) {
        
        int l = (league != null) ? league : 1;
        int s = (season != null) ? season : 2026;
        
        return syncService.syncWorldCup(l, s);
    }

    @GET
    @Path("/fixtures")
    public List<WorldCupFixture> getFixtures(
            @QueryParam("season") Integer season,
            @QueryParam("teamId") String teamId,
            @QueryParam("status") String status,
            @QueryParam("round") String round,
            @QueryParam("dateFrom") String dateFrom,
            @QueryParam("dateTo") String dateTo) {
        
        StringBuilder query = new StringBuilder("1=1");
        Map<String, Object> params = new HashMap<>();

        if (season != null) {
            query.append(" and season = :season");
            params.put("season", season);
        }
        if (teamId != null && !teamId.isEmpty()) {
            try {
                query.append(" and (homeTeam.id = :teamId or awayTeam.id = :teamId)");
                params.put("teamId", UUID.fromString(teamId));
            } catch (IllegalArgumentException e) {
                // Si no es UUID, ignoramos el filtro de teamId
            }
        }
        if (status != null && !status.isEmpty()) {
            query.append(" and statusShort = :status");
            params.put("status", status);
        }
        if (round != null && !round.isEmpty()) {
            query.append(" and round = :round");
            params.put("round", round);
        }
        if (dateFrom != null && !dateFrom.isEmpty()) {
            try {
                query.append(" and fixtureDate >= :dateFrom");
                params.put("dateFrom", LocalDate.parse(dateFrom).atStartOfDay());
            } catch (Exception e) {}
        }
        if (dateTo != null && !dateTo.isEmpty()) {
            try {
                query.append(" and fixtureDate <= :dateTo");
                params.put("dateTo", LocalDate.parse(dateTo).atTime(23, 59, 59));
            } catch (Exception e) {}
        }

        return WorldCupFixture.find(query.toString(), params).list();
    }
}
