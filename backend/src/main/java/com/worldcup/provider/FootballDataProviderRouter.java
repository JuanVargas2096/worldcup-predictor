package com.worldcup.provider;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.eclipse.microprofile.config.inject.ConfigProperty;

/**
 * Bean inyectable de {@link FootballDataProvider}: delega en el proveedor
 * configurado por {@code worldcup.data-provider} (mock | external).
 */
@ApplicationScoped
public class FootballDataProviderRouter implements FootballDataProvider {

    @ConfigProperty(name = "worldcup.data-provider", defaultValue = "mock")
    String configured;

    @Inject
    MockFootballDataProvider mock;

    @Inject
    ExternalApiFootballDataProvider external;

    private FootballDataProvider delegate() {
        return "external".equalsIgnoreCase(configured) ? external : mock;
    }

    @Override
    public String name() {
        return delegate().name();
    }

    @Override
    public int refreshRecentMatches() {
        return delegate().refreshRecentMatches();
    }
}
