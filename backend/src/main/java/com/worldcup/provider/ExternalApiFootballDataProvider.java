package com.worldcup.provider;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Typed;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.jboss.logging.Logger;

import java.util.Optional;

/**
 * Punto de extensión para conectar con una API real (API-Football / API-Sports,
 * Sportmonks, football-data.org). Hoy es un stub: NO trae datos reales todavía.
 *
 * Para implementarlo:
 *  1. Añadir un REST client (quarkus-rest-client-jackson) hacia la API.
 *  2. Configurar la API key vía variable de entorno FOOTBALL_API_KEY.
 *  3. Mapear fixtures/resultados al modelo MatchResult y persistirlos.
 *  4. Cambiar DATA_PROVIDER=external para activarlo.
 */
@ApplicationScoped
@Typed(ExternalApiFootballDataProvider.class)
public class ExternalApiFootballDataProvider implements FootballDataProvider {

    private static final Logger LOG = Logger.getLogger(ExternalApiFootballDataProvider.class);

    @ConfigProperty(name = "football.api.key")
    Optional<String> apiKey;

    @Override
    public String name() {
        return "external";
    }

    @Override
    public int refreshRecentMatches() {
        if (apiKey.isEmpty()) {
            LOG.warn("ExternalApiFootballDataProvider sin API key (football.api.key). "
                    + "No se importaron partidos. Configura FOOTBALL_API_KEY o usa DATA_PROVIDER=mock.");
            return 0;
        }
        // TODO: implementar llamadas reales a la API y mapear a MatchResult.
        LOG.info("ExternalApiFootballDataProvider aún no implementado. Pendiente: llamada real a la API.");
        return 0;
    }
}
