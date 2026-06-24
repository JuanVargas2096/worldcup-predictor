package com.worldcup.provider.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public record ApiFixture(
    FixtureDetail fixture,
    League league,
    Teams teams,
    Goals goals,
    Object score
) {
    @JsonIgnoreProperties(ignoreUnknown = true)
    public record FixtureDetail(long id, String date, String venue, String status) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record League(int id, String name, String country, String season, String round) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record Teams(TeamDetail home, TeamDetail away) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record TeamDetail(int id, String name, String logo, Boolean winner) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record Goals(Integer home, Integer away) {}
}
