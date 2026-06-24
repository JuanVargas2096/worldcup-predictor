package com.worldcup.provider.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public record ApiFixture(
    FixtureDetail fixture,
    League league,
    Teams teams,
    Goals goals,
    Score score
) {
    @JsonIgnoreProperties(ignoreUnknown = true)
    public record FixtureDetail(
        Integer id,
        String referee,
        String timezone,
        String date,
        Long timestamp,
        Venue venue,
        Status status
    ) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record Venue(Integer id, String name, String city) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record Status(
        @com.fasterxml.jackson.annotation.JsonProperty("long") String longStatus,
        @com.fasterxml.jackson.annotation.JsonProperty("short") String shortStatus,
        Integer elapsed,
        Integer extra
    ) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record League(Integer id, String name, String country, Integer season, String round) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record Teams(TeamDetail home, TeamDetail away) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record TeamDetail(Integer id, String name, String logo, Boolean winner) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record Goals(Integer home, Integer away) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record Score(
        ScoreDetail halftime,
        ScoreDetail fulltime,
        ScoreDetail extratime,
        ScoreDetail penalty
    ) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record ScoreDetail(Integer home, Integer away) {}
}
