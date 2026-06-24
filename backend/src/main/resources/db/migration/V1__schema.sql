-- World Cup Predictor 2026 - esquema inicial

CREATE TABLE teams (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code VARCHAR(3) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    confederation VARCHAR(20),
    fifa_ranking INT,
    elo_rating NUMERIC(10,2),
    previous_world_cup_result VARCHAR(30),
    group_letter CHAR(1),
    pot INT,
    flag_emoji VARCHAR(10),
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE matches (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    match_date DATE NOT NULL,
    home_team_id UUID NOT NULL REFERENCES teams(id),
    away_team_id UUID NOT NULL REFERENCES teams(id),
    home_score INT NOT NULL,
    away_score INT NOT NULL,
    competition VARCHAR(100),
    match_type VARCHAR(30),
    created_at TIMESTAMP NOT NULL DEFAULT now()
);
CREATE INDEX idx_matches_home ON matches(home_team_id);
CREATE INDEX idx_matches_away ON matches(away_team_id);
CREATE INDEX idx_matches_date ON matches(match_date DESC);

CREATE TABLE fixtures (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    group_letter CHAR(1) NOT NULL,
    matchday INT NOT NULL,
    scheduled_date DATE,
    venue VARCHAR(100),
    home_team_id UUID NOT NULL REFERENCES teams(id),
    away_team_id UUID NOT NULL REFERENCES teams(id),
    home_score INT,
    away_score INT,
    created_at TIMESTAMP NOT NULL DEFAULT now()
);
CREATE INDEX idx_fixtures_group ON fixtures(group_letter, matchday);

CREATE TABLE team_scores (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    team_id UUID NOT NULL REFERENCES teams(id),
    calculated_at TIMESTAMP NOT NULL DEFAULT now(),
    form_score NUMERIC(10,2),
    goal_diff_score NUMERIC(10,2),
    opponent_strength_score NUMERIC(10,2),
    previous_world_cup_score NUMERIC(10,2),
    elo_score NUMERIC(10,2),
    final_score NUMERIC(10,2),
    win_probability NUMERIC(6,3),
    explanation TEXT
);
CREATE INDEX idx_team_scores_team ON team_scores(team_id, calculated_at DESC);

CREATE TABLE scoring_config (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    form_weight NUMERIC(5,2) NOT NULL DEFAULT 0.40,
    goal_diff_weight NUMERIC(5,2) NOT NULL DEFAULT 0.20,
    opponent_strength_weight NUMERIC(5,2) NOT NULL DEFAULT 0.15,
    previous_world_cup_weight NUMERIC(5,2) NOT NULL DEFAULT 0.15,
    elo_weight NUMERIC(5,2) NOT NULL DEFAULT 0.10,
    active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP NOT NULL DEFAULT now()
);
