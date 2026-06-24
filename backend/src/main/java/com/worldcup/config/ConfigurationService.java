package com.worldcup.config;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Optional;

@ApplicationScoped
public class ConfigurationService {

    private static final Logger log = LoggerFactory.getLogger(ConfigurationService.class);

    /** Código en la tabla `configuration` donde se guarda la API key de API-Football. */
    public static final String API_KEY_CODE = "FOOTBALL_API_KEY";

    /**
     * Valor de la variable de entorno, usado SOLO como bootstrap/compatibilidad: si la BD aún no
     * tiene la key, se usa esta y se siembra en BD al arrancar (ver DataInitializer). La fuente de
     * verdad es la base de datos.
     */
    @ConfigProperty(name = "football.api.key")
    Optional<String> envApiKey;

    public String getValue(String code) {
        return Configuration.getValue(code, null);
    }

    /** API key efectiva: primero la BD; si falta, la variable de entorno (bootstrap). Null si no hay. */
    @Transactional
    public String getApiKey() {
        String dbKey = getValue(API_KEY_CODE);
        if (isValidKey(dbKey)) return dbKey;
        return envApiKey.filter(ConfigurationService::isValidKey).orElse(null);
    }

    public boolean hasApiKey() {
        return getApiKey() != null;
    }

    /** Origen actual de la key: "db", "env" o "none" (para diagnóstico). */
    @Transactional
    public String getApiKeySource() {
        if (isValidKey(getValue(API_KEY_CODE))) return "db";
        if (envApiKey.filter(ConfigurationService::isValidKey).isPresent()) return "env";
        return "none";
    }

    /** Guarda/actualiza la API key en la BD (fuente de verdad). */
    @Transactional
    public void setApiKey(String value) {
        setValue(API_KEY_CODE, value);
    }

    /** Variable de entorno cruda (solo para el bootstrap del arranque). */
    public Optional<String> getEnvApiKey() {
        return envApiKey.filter(ConfigurationService::isValidKey);
    }

    private static boolean isValidKey(String k) {
        return k != null && !k.isBlank() && !"NO_KEY".equals(k);
    }

    public int getIntValue(String code, int defaultValue) {
        String val = getValue(code);
        return val != null ? Integer.parseInt(val) : defaultValue;
    }

    /**
     * Intervalo mínimo (ms) entre llamadas a la API externa, para no exceder el límite por minuto.
     * Default 6500 ms (~9 req/min, seguro para la capa gratuita de 10/min). Configurable en BD.
     */
    @Transactional
    public int getApiMinIntervalMs() {
        return getIntValue("API_MIN_INTERVAL_MS", 6500);
    }

    @Transactional
    public void setValue(String code, String value) {
        Configuration config = Configuration.findByCode(code);
        if (config == null) {
            config = new Configuration();
            config.code = code;
        }
        config.value = value;
        config.updatedAt = LocalDateTime.now();
        config.persist();
    }

    @Transactional
    public boolean canMakeApiCall() {
        String lastCallDateStr = getValue("LAST_API_CALL_DATE");
        LocalDate lastCallDate = lastCallDateStr != null ? LocalDate.parse(lastCallDateStr) : LocalDate.MIN;
        LocalDate today = LocalDate.now();

        if (!today.equals(lastCallDate)) {
            setValue("API_CALLS_TODAY", "0");
            setValue("LAST_API_CALL_DATE", today.toString());
        }

        int callsToday = getIntValue("API_CALLS_TODAY", 0);
        int maxCalls = getIntValue("MAX_API_CALLS_PER_DAY", 100);

        return callsToday < maxCalls;
    }

    @Transactional
    public void registerApiCall() {
        int callsToday = getIntValue("API_CALLS_TODAY", 0);
        setValue("API_CALLS_TODAY", String.valueOf(callsToday + 1));
    }
}
