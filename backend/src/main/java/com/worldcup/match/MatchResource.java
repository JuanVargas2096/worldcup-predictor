package com.worldcup.match;

import com.worldcup.provider.ExternalApiFootballDataProvider;
import com.worldcup.team.Team;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Path("/api/matches")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class MatchResource {

    /**
     * Importación real (API-Football). El provider gestiona su HTTP fuera de
     * transacción y persiste en transacciones cortas; por eso este método NO es
     * @Transactional (no debe retener una conexión durante el HTTP).
     */
    @Inject
    ExternalApiFootballDataProvider externalProvider;

    @GET
    @Transactional
    public List<MatchDto> list(@QueryParam("limit") Integer limit) {
        int max = limit == null ? 200 : Math.min(limit, 1000);
        return MatchResult.<MatchResult>find("order by matchDate desc")
                .page(0, max).list()
                .stream().map(MatchDto::from).toList();
    }

    @GET
    @Path("/team/{teamId}/last-five")
    @Transactional
    public List<MatchDto> lastFive(@PathParam("teamId") UUID teamId) {
        if (Team.findById(teamId) == null) {
            throw new WebApplicationException("Equipo no encontrado", Response.Status.NOT_FOUND);
        }
        return MatchResult.lastMatchesForTeam(teamId, 5).stream().map(MatchDto::from).toList();
    }

    @POST
    @Transactional
    public Response create(@Valid MatchRequest req) {
        Team home = Team.findById(req.homeTeamId());
        Team away = Team.findById(req.awayTeamId());
        if (home == null || away == null) {
            throw new WebApplicationException("Equipo local o visitante inexistente",
                    Response.Status.BAD_REQUEST);
        }
        if (home.id.equals(away.id)) {
            throw new WebApplicationException("Un equipo no puede jugar contra sí mismo",
                    Response.Status.BAD_REQUEST);
        }
        MatchResult m = new MatchResult();
        m.matchDate = req.matchDate();
        m.homeTeam = home;
        m.awayTeam = away;
        m.homeScore = req.homeScore();
        m.awayScore = req.awayScore();
        m.competition = req.competition();
        m.matchType = req.matchType();
        m.persist();
        return Response.status(Response.Status.CREATED).entity(MatchDto.from(m)).build();
    }

    /** Importa partidos reales desde la API y los persiste (acción administrativa). */
    @POST
    @Path("/import")
    public Map<String, Object> importMatches() {
        int imported = externalProvider.refreshRecentMatches(true);
        return Map.of(
                "provider", externalProvider.name(),
                "imported", imported,
                "message", "Partidos reales importados desde la API");
    }
}
