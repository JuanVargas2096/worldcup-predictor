-- Tabla de configuración general del sistema
CREATE TABLE configuration (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255),
    value TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now()
);

-- Valores iniciales para control de API
INSERT INTO configuration (code, description, value) VALUES 
('MAX_API_CALLS_PER_DAY', 'Número máximo de peticiones permitidas a la API externa por día', '100'),
('API_CALLS_TODAY', 'Número de peticiones realizadas hoy', '0'),
('LAST_API_CALL_DATE', 'Fecha de la última petición realizada (YYYY-MM-DD)', '2026-06-23');
