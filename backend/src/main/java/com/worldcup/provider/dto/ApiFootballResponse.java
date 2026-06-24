package com.worldcup.provider.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public record ApiFootballResponse<T>(
    String get,
    Object parameters,
    List<Object> errors,
    int results,
    Paging paging,
    List<T> response
) {
    @JsonIgnoreProperties(ignoreUnknown = true)
    public record Paging(int current, int total) {}
}
