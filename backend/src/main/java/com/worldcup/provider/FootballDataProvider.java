package com.worldcup.provider;

/**
 * Abstracción de la fuente de datos de fútbol. Permite cambiar de proveedor
 * (mock, API-Football, Sportmonks, football-data.org) sin tocar el core.
 */
public interface FootballDataProvider {

    /** Nombre del proveedor (para trazabilidad). */
    String name();

    /**
     * Refresca los partidos recientes en la base de datos (resultados que
     * alimentan el cálculo de forma). Devuelve la cantidad de partidos cargados.
     */
    int refreshRecentMatches();
}
