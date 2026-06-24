CREATE TABLE app_parameter (
    id UUID PRIMARY KEY,
    parameter_key VARCHAR(255) UNIQUE NOT NULL,
    parameter_value VARCHAR(255) NOT NULL,
    description TEXT,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO app_parameter (id, parameter_key, parameter_value, description)
VALUES (gen_random_uuid(), 'WORLD_CUP_SYNC_RUNS_PER_DAY', '6', 'Cantidad de veces por día que se sincronizan partidos/equipos del Mundial 2026');

CREATE TABLE world_cup_team (
    id UUID PRIMARY KEY,
    api_team_id INTEGER UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    logo_url VARCHAR(255),
    country VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE world_cup_fixture (
    id UUID PRIMARY KEY,
    api_fixture_id INTEGER UNIQUE NOT NULL,
    league_id INTEGER,
    league_name VARCHAR(255),
    season INTEGER,
    round VARCHAR(100),
    referee VARCHAR(255),
    timezone VARCHAR(100),
    fixture_date TIMESTAMP,
    fixture_timestamp BIGINT,
    venue_id INTEGER,
    venue_name VARCHAR(255),
    venue_city VARCHAR(255),
    status_long VARCHAR(100),
    status_short VARCHAR(20),
    elapsed INTEGER,
    extra INTEGER,
    home_team_id UUID REFERENCES world_cup_team(id),
    away_team_id UUID REFERENCES world_cup_team(id),
    home_winner BOOLEAN,
    away_winner BOOLEAN,
    goals_home INTEGER,
    goals_away INTEGER,
    halftime_home INTEGER,
    halftime_away INTEGER,
    fulltime_home INTEGER,
    fulltime_away INTEGER,
    extratime_home INTEGER,
    extratime_away INTEGER,
    penalty_home INTEGER,
    penalty_away INTEGER,
    raw_response TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_wcf_api_fixture_id ON world_cup_fixture(api_fixture_id);
CREATE INDEX idx_wcf_season ON world_cup_fixture(season);
CREATE INDEX idx_wcf_round ON world_cup_fixture(round);
CREATE INDEX idx_wcf_fixture_date ON world_cup_fixture(fixture_date);
CREATE INDEX idx_wcf_home_team_id ON world_cup_fixture(home_team_id);
CREATE INDEX idx_wcf_away_team_id ON world_cup_fixture(away_team_id);
CREATE INDEX idx_wcf_status_short ON world_cup_fixture(status_short);
