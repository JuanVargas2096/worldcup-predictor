package com.worldcup.config;

import jakarta.ws.rs.WebApplicationException;

/**
 * Utilidades para respetar el límite de peticiones de API-Football (p. ej. 10/min y 100/día en la
 * capa gratuita). Evita ráfagas que provocan HTTP 429 ("Too many requests") al refrescar muchos
 * equipos/fixtures seguidos.
 */
public final class ApiRateLimit {

    private ApiRateLimit() {}

    /** True si la excepción corresponde a un rate-limit/cuota agotada (429, 412 o mensaje típico). */
    public static boolean isRateLimited(Throwable e) {
        for (Throwable t = e; t != null; t = t.getCause()) {
            if (t instanceof WebApplicationException wae && wae.getResponse() != null) {
                int s = wae.getResponse().getStatus();
                if (s == 429 || s == 412) return true;
            }
            String msg = t.getMessage();
            if (msg != null) {
                String m = msg.toLowerCase();
                if (m.contains("too many requests") || m.contains("rate limit") || m.contains("429")) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * True si el bloque {@code errors} de una respuesta 200 de API-Football indica límite alcanzado
     * (la API devuelve 200 con un objeto errors cuando se agota la cuota diaria).
     */
    public static boolean isRateLimitErrors(Object errors) {
        if (errors == null) return false;
        String s = errors.toString().toLowerCase();
        if (s.equals("[]") || s.equals("{}")) return false;
        return s.contains("limit") || s.contains("too many requests");
    }

    /** Espacia las llamadas durmiendo {@code millis}. No propaga la interrupción. */
    public static void throttle(long millis) {
        if (millis <= 0) return;
        try {
            Thread.sleep(millis);
        } catch (InterruptedException ie) {
            Thread.currentThread().interrupt();
        }
    }
}
