package com.worldcup.worldcup;

import java.util.List;

/** Una ronda del bracket (16avos, octavos, …) con sus partidos. */
public record BracketRoundDto(
        String round,
        List<BracketMatchDto> matches
) {}
