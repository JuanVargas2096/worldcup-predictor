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
@Table(name = "configuration")
public class Configuration extends PanacheEntityBase {

    @Id
    @GeneratedValue
    public UUID id;

    @Column(nullable = false, unique = true)
    public String code;

    public String description;

    @Column(columnDefinition = "TEXT")
    public String value;

    @Column(name = "created_at")
    public LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "updated_at")
    public LocalDateTime updatedAt = LocalDateTime.now();

    public static Configuration findByCode(String code) {
        return find("code", code).firstResult();
    }

    public static String getValue(String code, String defaultValue) {
        Configuration config = findByCode(code);
        return config != null ? config.value : defaultValue;
    }
}
