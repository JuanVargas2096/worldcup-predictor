package com.worldcup.provider;

import com.worldcup.provider.dto.ApiFootballResponse;
import com.worldcup.provider.dto.ApiFixture;
import com.worldcup.provider.dto.ApiPrediction;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.HeaderParam;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.QueryParam;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

@RegisterRestClient(configKey = "football-api")
public interface ApiFootballClient {

    @GET
    @Path("/fixtures")
    ApiFootballResponse<ApiFixture> getFixtures(
            @HeaderParam("x-apisports-key") String apiKey,
            @QueryParam("league") Integer leagueId,
            @QueryParam("season") Integer season,
            @QueryParam("team") Integer teamId,
            @QueryParam("last") Integer last,
            @QueryParam("status") String status
    );

    /** Predicciones de un partido concreto (percent home/draw/away, advice, winner). */
    @GET
    @Path("/predictions")
    ApiFootballResponse<ApiPrediction> getPredictions(
            @HeaderParam("x-apisports-key") String apiKey,
            @QueryParam("fixture") Integer fixtureId
    );
}
