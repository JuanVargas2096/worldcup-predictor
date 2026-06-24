package com.worldcup.worldcup;

import io.quarkus.panache.common.Parameters;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Path("/api/world-cup")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class WorldCupResource {

    @Inject
    WorldCupSyncService syncService;

    /** Sincronización manual (hace HTTP a la API; acción administrativa puntual). */
    @POST
    @Path("/sync")
    public SyncResult manualSync(
            @QueryParam("league") Integer league,
            @QueryParam("season") Integer season) {
        int l = (league != null) ? league : 1;
        int s = (season != null) ? season : 2026;
        return syncService.syncWorldCup(l, s);
    }

    /**
     * Lista partidos reales sincronizados (SOLO lectura de BD, sin llamadas externas).
     * Mapea a DTO dentro de la transacción para evitar LazyInitializationException.
     */
    @GET
    @Path("/fixtures")
    @Transactional
    public List<WorldCupFixtureDto> getFixtures(
            @QueryParam("season") Integer season,
            @QueryParam("teamId") String teamId,
            @QueryParam("status") String status,
            @QueryParam("round") String round,
            @QueryParam("dateFrom") String dateFrom,
            @QueryParam("dateTo") String dateTo) {

        StringBuilder query = new StringBuilder("1=1");
        Parameters params = new Parameters();

        if (season != null) {
            query.append(" and season = :season");
            params.and("season", season);
        }
        if (teamId != null && !teamId.isEmpty()) {
            try {
                UUID id = UUID.fromString(teamId);
                query.append(" and (homeTeam.id = :teamId or awayTeam.id = :teamId)");
                params.and("teamId", id);
            } catch (IllegalArgumentException ignored) {
                // teamId no es UUID válido: se ignora el filtro
            }
        }
        if (status != null && !status.isEmpty()) {
            query.append(" and statusShort = :status");
            params.and("status", status);
        }
        if (round != null && !round.isEmpty()) {
            query.append(" and round = :round");
            params.and("round", round);
        }
        if (dateFrom != null && !dateFrom.isEmpty()) {
            try {
                query.append(" and fixtureDate >= :dateFrom");
                params.and("dateFrom", LocalDate.parse(dateFrom).atStartOfDay());
            } catch (Exception ignored) { }
        }
        if (dateTo != null && !dateTo.isEmpty()) {
            try {
                query.append(" and fixtureDate <= :dateTo");
                params.and("dateTo", LocalDate.parse(dateTo).atTime(23, 59, 59));
            } catch (Exception ignored) { }
        }

        query.append(" order by fixtureDate asc");

        return WorldCupFixture.<WorldCupFixture>find(query.toString(), params)
                .list()
                .stream()
                .map(WorldCupFixtureDto::from)
                .toList();
    }
}
