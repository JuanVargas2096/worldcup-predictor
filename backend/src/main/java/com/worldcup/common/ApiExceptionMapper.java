package com.worldcup.common;

import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.ext.ExceptionMapper;
import jakarta.ws.rs.ext.Provider;

import java.util.Map;

/** Convierte WebApplicationException en una respuesta JSON consistente. */
@Provider
public class ApiExceptionMapper implements ExceptionMapper<WebApplicationException> {

    @Override
    public Response toResponse(WebApplicationException ex) {
        int status = ex.getResponse() != null ? ex.getResponse().getStatus() : 500;
        return Response.status(status)
                .entity(Map.of(
                        "status", status,
                        "error", ex.getMessage() == null ? "Error" : ex.getMessage()))
                .build();
    }
}
