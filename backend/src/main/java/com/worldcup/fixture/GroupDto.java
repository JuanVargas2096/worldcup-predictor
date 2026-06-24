package com.worldcup.fixture;

import com.worldcup.team.TeamDto;

import java.util.List;

/** Un grupo del Mundial: sus equipos (ordenados por pot) y su calendario. */
public record GroupDto(
        String groupLetter,
        List<TeamDto> teams,
        List<FixtureDto> fixtures
) {}
