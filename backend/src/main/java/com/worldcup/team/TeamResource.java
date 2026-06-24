package com.worldcup.team;

import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Path("/api/teams")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class TeamResource {

    @GET
    public List<TeamDto> list() {
        return Team.listAllOrdered().stream().map(TeamDto::from).toList();
    }

    @GET
    @Path("/{id}")
    public TeamDto get(@PathParam("id") UUID id) {
        Team team = Team.findById(id);
        if (team == null) {
            throw new WebApplicationException("Equipo no encontrado", Response.Status.NOT_FOUND);
        }
        return TeamDto.from(team);
    }

    @POST
    @Transactional
    public Response create(@Valid TeamRequest req) {
        if (Team.findByCode(req.code()) != null) {
            throw new WebApplicationException("Ya existe un equipo con código " + req.code(),
                    Response.Status.CONFLICT);
        }
        Team team = new Team();
        apply(team, req);
        team.persist();
        return Response.status(Response.Status.CREATED).entity(TeamDto.from(team)).build();
    }

    @PUT
    @Path("/{id}")
    @Transactional
    public TeamDto update(@PathParam("id") UUID id, @Valid TeamRequest req) {
        Team team = Team.findById(id);
        if (team == null) {
            throw new WebApplicationException("Equipo no encontrado", Response.Status.NOT_FOUND);
        }
        apply(team, req);
        team.updatedAt = LocalDateTime.now();
        return TeamDto.from(team);
    }

    @DELETE
    @Path("/{id}")
    @Transactional
    public Response delete(@PathParam("id") UUID id) {
        boolean deleted = Team.deleteById(id);
        if (!deleted) {
            throw new WebApplicationException("Equipo no encontrado", Response.Status.NOT_FOUND);
        }
        return Response.noContent().build();
    }

    private void apply(Team team, TeamRequest req) {
        team.code = req.code();
        team.name = req.name();
        team.confederation = req.confederation();
        team.fifaRanking = req.fifaRanking();
        team.eloRating = req.eloRating();
        team.previousWorldCupResult = req.previousWorldCupResult();
        team.groupLetter = req.groupLetter();
        team.pot = req.pot();
        team.flagEmoji = req.flagEmoji();
    }
}
