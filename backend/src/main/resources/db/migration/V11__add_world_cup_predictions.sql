-- Predicciones por partido (endpoint /predictions de API-Football), persistidas DB-first.
-- win_home/win_away = probabilidad de AVANZAR (en knockout no hay empate): se redistribuye
-- el % de empate proporcionalmente entre ambos equipos.
CREATE TABLE world_cup_prediction (
    id UUID PRIMARY KEY,
    api_fixture_id INTEGER UNIQUE NOT NULL,
    percent_home INTEGER,
    percent_draw INTEGER,
    percent_away INTEGER,
    win_home NUMERIC(6,3),
    win_away NUMERIC(6,3),
    advice TEXT,
    winner_name VARCHAR(255),
    winner_comment TEXT,
    raw_response TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_wcp_api_fixture_id ON world_cup_prediction(api_fixture_id);
