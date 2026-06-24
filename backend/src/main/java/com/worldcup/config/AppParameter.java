package com.worldcup.config;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "app_parameter")
public class AppParameter extends PanacheEntityBase {

    @Id
    @GeneratedValue
    public UUID id;

    @Column(name = "parameter_key", nullable = false, unique = true)
    public String key;

    @Column(name = "parameter_value", nullable = false)
    public String value;

    public String description;

    public boolean active = true;

    @Column(name = "created_at")
    public LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "updated_at")
    public LocalDateTime updatedAt = LocalDateTime.now();

    public static AppParameter findByKey(String key) {
        return find("key", key).firstResult();
    }

    public static String getValue(String key, String defaultValue) {
        AppParameter param = findByKey(key);
        if (param == null || !param.active) return defaultValue;
        return param.value;
    }
}
