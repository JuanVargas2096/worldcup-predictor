package com.worldcup.config;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDate;
import java.time.LocalDateTime;

@ApplicationScoped
public class ConfigurationService {

    private static final Logger log = LoggerFactory.getLogger(ConfigurationService.class);

    public String getValue(String code) {
        return Configuration.getValue(code, null);
    }

    public int getIntValue(String code, int defaultValue) {
        String val = getValue(code);
        return val != null ? Integer.parseInt(val) : defaultValue;
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
