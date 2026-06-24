package com.worldcup.provider.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Respuesta del endpoint /predictions de API-Football. Solo se mapean los campos que usamos:
 * el bloque {@code predictions} (winner, advice, percent home/draw/away) y los IDs de los equipos.
 * Los porcentajes vienen como string tipo "45%".
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public record ApiPrediction(
        Predictions predictions,
        Teams teams
) {
    @JsonIgnoreProperties(ignoreUnknown = true)
    public record Predictions(
            Winner winner,
            String advice,
            Percent percent
    ) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record Winner(Integer id, String name, String comment) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record Percent(String home, String draw, String away) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record Teams(TeamRef home, TeamRef away) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record TeamRef(Integer id, String name) {}
}
