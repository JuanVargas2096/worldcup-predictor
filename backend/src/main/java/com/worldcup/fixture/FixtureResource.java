package com.worldcup.fixture;

import com.worldcup.team.Team;
import com.worldcup.team.TeamDto;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import java.util.Comparator;
import java.util.List;

@Path("/api")
@Produces(MediaType.APPLICATION_JSON)
public class FixtureResource {

    /** Todos los partidos de la fase de grupos. */
    @GET
    @Path("/fixtures")
    public List<FixtureDto> allFixtures() {
        return Fixture.allOrdered().stream().map(FixtureDto::from).toList();
    }

    /** Partidos de un grupo concreto. */
    @GET
    @Path("/fixtures/group/{letter}")
    public List<FixtureDto> byGroup(@PathParam("letter") String letter) {
        return Fixture.byGroup(letter.toUpperCase()).stream().map(FixtureDto::from).toList();
    }

    /** Los 12 grupos con equipos y calendario (vista principal del fixture). */
    @GET
    @Path("/groups")
    public List<GroupDto> groups() {
        String[] letters = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"};
        return java.util.Arrays.stream(letters).map(letter -> {
            List<TeamDto> teams = Team.<Team>list("groupLetter = ?1 order by pot asc", letter)
                    .stream().map(TeamDto::from).toList();
            List<FixtureDto> fixtures = Fixture.byGroup(letter).stream()
                    .sorted(Comparator.comparingInt((Fixture f) -> f.matchday))
                    .map(FixtureDto::from).toList();
            return new GroupDto(letter, teams, fixtures);
        }).toList();
    }
}
