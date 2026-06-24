package com.worldcup.config;

import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

/**
 * Gestión de la configuración del sistema persistida en BD. En particular, la API key de
 * API-Football: la fuente de verdad es la tabla `configuration` (code FOOTBALL_API_KEY), no la
 * variable de entorno. Este recurso permite consultarla (enmascarada) y actualizarla.
 */
@Path("/api/config")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ConfigResource {

    @Inject
    ConfigurationService configurationService;

    public record ApiKeyStatus(boolean configured, String source, String masked) {}

    public record ApiKeyRequest(String value) {}

    /** Estado de la API key: si está configurada, su origen (db/env/none) y una vista enmascarada. */
    @GET
    @Path("/api-key")
    public ApiKeyStatus getApiKeyStatus() {
        String key = configurationService.getApiKey();
        return new ApiKeyStatus(key != null, configurationService.getApiKeySource(), mask(key));
    }

    /** Guarda/actualiza la API key en BD. */
    @PUT
    @Path("/api-key")
    public ApiKeyStatus setApiKey(ApiKeyRequest req) {
        if (req == null || req.value() == null || req.value().isBlank()) {
            throw new WebApplicationException("La API key no puede estar vacía.", Response.Status.BAD_REQUEST);
        }
        configurationService.setApiKey(req.value().trim());
        String key = configurationService.getApiKey();
        return new ApiKeyStatus(key != null, configurationService.getApiKeySource(), mask(key));
    }

    /** Enmascara la key dejando visibles solo los últimos 4 caracteres. */
    private static String mask(String key) {
        if (key == null || key.isBlank()) return null;
        if (key.length() <= 4) return "••••";
        return "••••" + key.substring(key.length() - 4);
    }
}
