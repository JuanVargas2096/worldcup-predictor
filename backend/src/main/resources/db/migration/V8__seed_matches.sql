-- Semilla de partidos históricos generada el Wed Jun 24 15:12:23 -03 2026
-- Basado en API-Football v3

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Mexico', 3)), 'Mexico', '🏳️', 16 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 16);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Panama', 3)), 'Panama', '🏳️', 11 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 11);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-03-24', (SELECT id FROM teams WHERE api_id = 16), (SELECT id FROM teams WHERE api_id = 11), 2, 1, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-03-24' AND home_team_id = (SELECT id FROM teams WHERE api_id = 16) AND away_team_id = (SELECT id FROM teams WHERE api_id = 11));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Canada', 3)), 'Canada', '🏳️', 5529 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5529);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Mexico', 3)), 'Mexico', '🏳️', 16 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 16);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-03-21', (SELECT id FROM teams WHERE api_id = 5529), (SELECT id FROM teams WHERE api_id = 16), 0, 2, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-03-21' AND home_team_id = (SELECT id FROM teams WHERE api_id = 5529) AND away_team_id = (SELECT id FROM teams WHERE api_id = 16));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Mexico', 3)), 'Mexico', '🏳️', 16 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 16);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Honduras', 3)), 'Honduras', '🏳️', 4672 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 4672);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-11-20', (SELECT id FROM teams WHERE api_id = 16), (SELECT id FROM teams WHERE api_id = 4672), 4, 0, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-11-20' AND home_team_id = (SELECT id FROM teams WHERE api_id = 16) AND away_team_id = (SELECT id FROM teams WHERE api_id = 4672));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Honduras', 3)), 'Honduras', '🏳️', 4672 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 4672);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Mexico', 3)), 'Mexico', '🏳️', 16 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 16);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-11-16', (SELECT id FROM teams WHERE api_id = 4672), (SELECT id FROM teams WHERE api_id = 16), 2, 0, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-11-16' AND home_team_id = (SELECT id FROM teams WHERE api_id = 4672) AND away_team_id = (SELECT id FROM teams WHERE api_id = 16));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Mexico', 3)), 'Mexico', '🏳️', 16 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 16);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('USA', 3)), 'USA', '🏳️', 2384 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2384);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-10-16', (SELECT id FROM teams WHERE api_id = 16), (SELECT id FROM teams WHERE api_id = 2384), 2, 0, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-10-16' AND home_team_id = (SELECT id FROM teams WHERE api_id = 16) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2384));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Iraq', 3)), 'Iraq', '🏳️', 1567 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1567);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('South Korea', 3)), 'South Korea', '🏳️', 17 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 17);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-06', (SELECT id FROM teams WHERE api_id = 1567), (SELECT id FROM teams WHERE api_id = 17), 0, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-06' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1567) AND away_team_id = (SELECT id FROM teams WHERE api_id = 17));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Czechia', 3)), 'Czechia', '🏳️', 770 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 770);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Gibraltar', 3)), 'Gibraltar', '🏳️', 1093 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1093);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-17', (SELECT id FROM teams WHERE api_id = 770), (SELECT id FROM teams WHERE api_id = 1093), 6, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-17' AND home_team_id = (SELECT id FROM teams WHERE api_id = 770) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1093));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Faroe Islands', 3)), 'Faroe Islands', '🏳️', 1098 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1098);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Czechia', 3)), 'Czechia', '🏳️', 770 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 770);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-12', (SELECT id FROM teams WHERE api_id = 1098), (SELECT id FROM teams WHERE api_id = 770), 2, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-12' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1098) AND away_team_id = (SELECT id FROM teams WHERE api_id = 770));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Czechia', 3)), 'Czechia', '🏳️', 770 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 770);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Croatia', 3)), 'Croatia', '🏳️', 3 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 3);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-09', (SELECT id FROM teams WHERE api_id = 770), (SELECT id FROM teams WHERE api_id = 3), 0, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 770) AND away_team_id = (SELECT id FROM teams WHERE api_id = 3));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Montenegro', 3)), 'Montenegro', '🏳️', 1109 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1109);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Czechia', 3)), 'Czechia', '🏳️', 770 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 770);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-05', (SELECT id FROM teams WHERE api_id = 1109), (SELECT id FROM teams WHERE api_id = 770), 0, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-05' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1109) AND away_team_id = (SELECT id FROM teams WHERE api_id = 770));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Croatia', 3)), 'Croatia', '🏳️', 3 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 3);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Czechia', 3)), 'Czechia', '🏳️', 770 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 770);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-06-09', (SELECT id FROM teams WHERE api_id = 3), (SELECT id FROM teams WHERE api_id = 770), 5, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-06-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 3) AND away_team_id = (SELECT id FROM teams WHERE api_id = 770));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('South Africa', 3)), 'South Africa', '🏳️', 1531 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1531);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Uganda', 3)), 'Uganda', '🏳️', 1519 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1519);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-18', (SELECT id FROM teams WHERE api_id = 1531), (SELECT id FROM teams WHERE api_id = 1519), 3, 3, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-18' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1531) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1519));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Niger', 3)), 'Niger', '🏳️', 1505 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1505);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('South Africa', 3)), 'South Africa', '🏳️', 1531 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1531);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-15', (SELECT id FROM teams WHERE api_id = 1505), (SELECT id FROM teams WHERE api_id = 1531), 0, 0, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1505) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1531));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('South Africa', 3)), 'South Africa', '🏳️', 1531 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1531);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Guinea', 3)), 'Guinea', '🏳️', 1509 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1509);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-11', (SELECT id FROM teams WHERE api_id = 1531), (SELECT id FROM teams WHERE api_id = 1509), 2, 1, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-11' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1531) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1509));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Algeria', 3)), 'Algeria', '🏳️', 1532 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1532);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('South Africa', 3)), 'South Africa', '🏳️', 1531 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1531);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-08', (SELECT id FROM teams WHERE api_id = 1532), (SELECT id FROM teams WHERE api_id = 1531), 1, 1, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-08' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1532) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1531));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('South Africa', 3)), 'South Africa', '🏳️', 1531 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1531);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Malawi', 3)), 'Malawi', '🏳️', 1495 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1495);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-05-11', (SELECT id FROM teams WHERE api_id = 1531), (SELECT id FROM teams WHERE api_id = 1495), 2, 0, 'African Nations Championship - Qualification', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-05-11' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1531) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1495));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Canada', 3)), 'Canada', '🏳️', 5529 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5529);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('USA', 3)), 'USA', '🏳️', 2384 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2384);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-03-22', (SELECT id FROM teams WHERE api_id = 5529), (SELECT id FROM teams WHERE api_id = 2384), 2, 1, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-03-22' AND home_team_id = (SELECT id FROM teams WHERE api_id = 5529) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2384));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Canada', 3)), 'Canada', '🏳️', 5529 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5529);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Mexico', 3)), 'Mexico', '🏳️', 16 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 16);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-03-21', (SELECT id FROM teams WHERE api_id = 5529), (SELECT id FROM teams WHERE api_id = 16), 0, 2, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-03-21' AND home_team_id = (SELECT id FROM teams WHERE api_id = 5529) AND away_team_id = (SELECT id FROM teams WHERE api_id = 16));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Canada', 3)), 'Canada', '🏳️', 5529 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5529);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Suriname', 3)), 'Suriname', '🏳️', 8171 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 8171);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-11-20', (SELECT id FROM teams WHERE api_id = 5529), (SELECT id FROM teams WHERE api_id = 8171), 3, 0, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-11-20' AND home_team_id = (SELECT id FROM teams WHERE api_id = 5529) AND away_team_id = (SELECT id FROM teams WHERE api_id = 8171));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Suriname', 3)), 'Suriname', '🏳️', 8171 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 8171);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Canada', 3)), 'Canada', '🏳️', 5529 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5529);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-11-15', (SELECT id FROM teams WHERE api_id = 8171), (SELECT id FROM teams WHERE api_id = 5529), 0, 1, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-11-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 8171) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5529));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Canada', 3)), 'Canada', '🏳️', 5529 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5529);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Panama', 3)), 'Panama', '🏳️', 11 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 11);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-10-15', (SELECT id FROM teams WHERE api_id = 5529), (SELECT id FROM teams WHERE api_id = 11), 2, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-10-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 5529) AND away_team_id = (SELECT id FROM teams WHERE api_id = 11));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Kosovo', 3)), 'Kosovo', '🏳️', 1111 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1111);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Switzerland', 3)), 'Switzerland', '🏳️', 15 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 15);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-18', (SELECT id FROM teams WHERE api_id = 1111), (SELECT id FROM teams WHERE api_id = 15), 1, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-18' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1111) AND away_team_id = (SELECT id FROM teams WHERE api_id = 15));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Switzerland', 3)), 'Switzerland', '🏳️', 15 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 15);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Sweden', 3)), 'Sweden', '🏳️', 5 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-15', (SELECT id FROM teams WHERE api_id = 15), (SELECT id FROM teams WHERE api_id = 5), 4, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 15) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Slovenia', 3)), 'Slovenia', '🏳️', 1091 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1091);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Switzerland', 3)), 'Switzerland', '🏳️', 15 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 15);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-13', (SELECT id FROM teams WHERE api_id = 1091), (SELECT id FROM teams WHERE api_id = 15), 0, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-13' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1091) AND away_team_id = (SELECT id FROM teams WHERE api_id = 15));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Sweden', 3)), 'Sweden', '🏳️', 5 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Switzerland', 3)), 'Switzerland', '🏳️', 15 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 15);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-10', (SELECT id FROM teams WHERE api_id = 5), (SELECT id FROM teams WHERE api_id = 15), 0, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-10' AND home_team_id = (SELECT id FROM teams WHERE api_id = 5) AND away_team_id = (SELECT id FROM teams WHERE api_id = 15));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Switzerland', 3)), 'Switzerland', '🏳️', 15 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 15);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Slovenia', 3)), 'Slovenia', '🏳️', 1091 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1091);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-08', (SELECT id FROM teams WHERE api_id = 15), (SELECT id FROM teams WHERE api_id = 1091), 3, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-08' AND home_team_id = (SELECT id FROM teams WHERE api_id = 15) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1091));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Kuwait', 3)), 'Kuwait', '🏳️', 1570 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1570);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Qatar', 3)), 'Qatar', '🏳️', 1569 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1569);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-27', (SELECT id FROM teams WHERE api_id = 1570), (SELECT id FROM teams WHERE api_id = 1569), 1, 1, 'Gulf Cup of Nations', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-27' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1570) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1569));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Oman', 3)), 'Oman', '🏳️', 1552 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1552);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Qatar', 3)), 'Qatar', '🏳️', 1569 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1569);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-24', (SELECT id FROM teams WHERE api_id = 1552), (SELECT id FROM teams WHERE api_id = 1569), 2, 1, 'Gulf Cup of Nations', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-24' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1552) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1569));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Qatar', 3)), 'Qatar', '🏳️', 1569 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1569);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('United Arab Emirates', 3)), 'United Arab Emirates', '🏳️', 1563 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1563);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-21', (SELECT id FROM teams WHERE api_id = 1569), (SELECT id FROM teams WHERE api_id = 1563), 1, 1, 'Gulf Cup of Nations', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-21' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1569) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1563));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Qatar', 3)), 'Qatar', '🏳️', 1569 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1569);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Jordan', 3)), 'Jordan', '🏳️', 1548 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1548);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-05', (SELECT id FROM teams WHERE api_id = 1569), (SELECT id FROM teams WHERE api_id = 1548), 1, 2, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-05' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1569) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1548));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Austria', 3)), 'Austria', '🏳️', 775 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 775);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Bosnia & Herzegovina', 3)), 'Bosnia & Herzegovina', '🏳️', 1113 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1113);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-18', (SELECT id FROM teams WHERE api_id = 775), (SELECT id FROM teams WHERE api_id = 1113), 1, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-18' AND home_team_id = (SELECT id FROM teams WHERE api_id = 775) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1113));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Bosnia & Herzegovina', 3)), 'Bosnia & Herzegovina', '🏳️', 1113 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1113);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Romania', 3)), 'Romania', '🏳️', 774 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 774);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-15', (SELECT id FROM teams WHERE api_id = 1113), (SELECT id FROM teams WHERE api_id = 774), 3, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1113) AND away_team_id = (SELECT id FROM teams WHERE api_id = 774));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Cyprus', 3)), 'Cyprus', '🏳️', 1106 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1106);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Bosnia & Herzegovina', 3)), 'Bosnia & Herzegovina', '🏳️', 1113 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1113);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-09', (SELECT id FROM teams WHERE api_id = 1106), (SELECT id FROM teams WHERE api_id = 1113), 2, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1106) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1113));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Bosnia & Herzegovina', 3)), 'Bosnia & Herzegovina', '🏳️', 1113 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1113);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Austria', 3)), 'Austria', '🏳️', 775 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 775);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-09', (SELECT id FROM teams WHERE api_id = 1113), (SELECT id FROM teams WHERE api_id = 775), 1, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1113) AND away_team_id = (SELECT id FROM teams WHERE api_id = 775));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('San Marino', 3)), 'San Marino', '🏳️', 1115 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1115);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Bosnia & Herzegovina', 3)), 'Bosnia & Herzegovina', '🏳️', 1113 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1113);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-06', (SELECT id FROM teams WHERE api_id = 1115), (SELECT id FROM teams WHERE api_id = 1113), 0, 6, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-06' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1115) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1113));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Brazil', 3)), 'Brazil', '🏳️', 6 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 6);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Colombia', 3)), 'Colombia', '🏳️', 8 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 8);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-07-03', (SELECT id FROM teams WHERE api_id = 6), (SELECT id FROM teams WHERE api_id = 8), 1, 1, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-07-03' AND home_team_id = (SELECT id FROM teams WHERE api_id = 6) AND away_team_id = (SELECT id FROM teams WHERE api_id = 8));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Paraguay', 3)), 'Paraguay', '🏳️', 2380 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2380);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Brazil', 3)), 'Brazil', '🏳️', 6 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 6);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-29', (SELECT id FROM teams WHERE api_id = 2380), (SELECT id FROM teams WHERE api_id = 6), 1, 4, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-29' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2380) AND away_team_id = (SELECT id FROM teams WHERE api_id = 6));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Brazil', 3)), 'Brazil', '🏳️', 6 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 6);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Costa Rica', 3)), 'Costa Rica', '🏳️', 29 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 29);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-25', (SELECT id FROM teams WHERE api_id = 6), (SELECT id FROM teams WHERE api_id = 29), 0, 0, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-25' AND home_team_id = (SELECT id FROM teams WHERE api_id = 6) AND away_team_id = (SELECT id FROM teams WHERE api_id = 29));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('USA', 3)), 'USA', '🏳️', 2384 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2384);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Brazil', 3)), 'Brazil', '🏳️', 6 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 6);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-12', (SELECT id FROM teams WHERE api_id = 2384), (SELECT id FROM teams WHERE api_id = 6), 1, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-12' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2384) AND away_team_id = (SELECT id FROM teams WHERE api_id = 6));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Mexico', 3)), 'Mexico', '🏳️', 16 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 16);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Brazil', 3)), 'Brazil', '🏳️', 6 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 6);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-09', (SELECT id FROM teams WHERE api_id = 16), (SELECT id FROM teams WHERE api_id = 6), 2, 3, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 16) AND away_team_id = (SELECT id FROM teams WHERE api_id = 6));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Madagascar', 3)), 'Madagascar', '🏳️', 1490 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1490);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Morocco', 3)), 'Morocco', '🏳️', 31 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 31);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-30', (SELECT id FROM teams WHERE api_id = 1490), (SELECT id FROM teams WHERE api_id = 31), 2, 3, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-30' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1490) AND away_team_id = (SELECT id FROM teams WHERE api_id = 31));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Tanzania', 3)), 'Tanzania', '🏳️', 1489 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1489);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Morocco', 3)), 'Morocco', '🏳️', 31 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 31);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-22', (SELECT id FROM teams WHERE api_id = 1489), (SELECT id FROM teams WHERE api_id = 31), 0, 1, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-22' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1489) AND away_team_id = (SELECT id FROM teams WHERE api_id = 31));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Congo DR', 3)), 'Congo DR', '🏳️', 1508 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1508);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Morocco', 3)), 'Morocco', '🏳️', 31 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 31);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-17', (SELECT id FROM teams WHERE api_id = 1508), (SELECT id FROM teams WHERE api_id = 31), 1, 3, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-17' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1508) AND away_team_id = (SELECT id FROM teams WHERE api_id = 31));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Morocco', 3)), 'Morocco', '🏳️', 31 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 31);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Zambia', 3)), 'Zambia', '🏳️', 1507 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1507);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-14', (SELECT id FROM teams WHERE api_id = 31), (SELECT id FROM teams WHERE api_id = 1507), 3, 1, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-14' AND home_team_id = (SELECT id FROM teams WHERE api_id = 31) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1507));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Kenya', 3)), 'Kenya', '🏳️', 1511 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1511);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Morocco', 3)), 'Morocco', '🏳️', 31 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 31);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-10', (SELECT id FROM teams WHERE api_id = 1511), (SELECT id FROM teams WHERE api_id = 31), 1, 0, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-10' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1511) AND away_team_id = (SELECT id FROM teams WHERE api_id = 31));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Scotland', 3)), 'Scotland', '🏳️', 1108 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1108);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Denmark', 3)), 'Denmark', '🏳️', 21 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 21);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-18', (SELECT id FROM teams WHERE api_id = 1108), (SELECT id FROM teams WHERE api_id = 21), 4, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-18' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1108) AND away_team_id = (SELECT id FROM teams WHERE api_id = 21));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Greece', 3)), 'Greece', '🏳️', 1117 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1117);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Scotland', 3)), 'Scotland', '🏳️', 1108 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1108);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-15', (SELECT id FROM teams WHERE api_id = 1117), (SELECT id FROM teams WHERE api_id = 1108), 3, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1117) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1108));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Scotland', 3)), 'Scotland', '🏳️', 1108 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1108);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Belarus', 3)), 'Belarus', '🏳️', 1100 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1100);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-12', (SELECT id FROM teams WHERE api_id = 1108), (SELECT id FROM teams WHERE api_id = 1100), 2, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-12' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1108) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1100));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Scotland', 3)), 'Scotland', '🏳️', 1108 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1108);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Greece', 3)), 'Greece', '🏳️', 1117 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1117);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-09', (SELECT id FROM teams WHERE api_id = 1108), (SELECT id FROM teams WHERE api_id = 1117), 3, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1108) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1117));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Belarus', 3)), 'Belarus', '🏳️', 1100 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1100);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Scotland', 3)), 'Scotland', '🏳️', 1108 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1108);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-08', (SELECT id FROM teams WHERE api_id = 1100), (SELECT id FROM teams WHERE api_id = 1108), 0, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-08' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1100) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1108));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Haiti', 3)), 'Haiti', '🏳️', 2386 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2386);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Puerto Rico', 3)), 'Puerto Rico', '🏳️', 5539 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5539);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-11-19', (SELECT id FROM teams WHERE api_id = 2386), (SELECT id FROM teams WHERE api_id = 5539), 3, 0, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-11-19' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2386) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5539));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Sint Maarten', 3)), 'Sint Maarten', '🏳️', 10985 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 10985);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Haiti', 3)), 'Haiti', '🏳️', 2386 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2386);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-11-15', (SELECT id FROM teams WHERE api_id = 10985), (SELECT id FROM teams WHERE api_id = 2386), 0, 8, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-11-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 10985) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2386));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Haiti', 3)), 'Haiti', '🏳️', 2386 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2386);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Aruba', 3)), 'Aruba', '🏳️', 8167 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 8167);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-10-15', (SELECT id FROM teams WHERE api_id = 2386), (SELECT id FROM teams WHERE api_id = 8167), 5, 3, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-10-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2386) AND away_team_id = (SELECT id FROM teams WHERE api_id = 8167));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Aruba', 3)), 'Aruba', '🏳️', 8167 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 8167);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Haiti', 3)), 'Haiti', '🏳️', 2386 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2386);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-10-12', (SELECT id FROM teams WHERE api_id = 8167), (SELECT id FROM teams WHERE api_id = 2386), 1, 3, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-10-12' AND home_team_id = (SELECT id FROM teams WHERE api_id = 8167) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2386));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Haiti', 3)), 'Haiti', '🏳️', 2386 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2386);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Sint Maarten', 3)), 'Sint Maarten', '🏳️', 10985 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 10985);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-09-09', (SELECT id FROM teams WHERE api_id = 2386), (SELECT id FROM teams WHERE api_id = 10985), 6, 0, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-09-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2386) AND away_team_id = (SELECT id FROM teams WHERE api_id = 10985));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Canada', 3)), 'Canada', '🏳️', 5529 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5529);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('USA', 3)), 'USA', '🏳️', 2384 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2384);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-03-22', (SELECT id FROM teams WHERE api_id = 5529), (SELECT id FROM teams WHERE api_id = 2384), 2, 1, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-03-22' AND home_team_id = (SELECT id FROM teams WHERE api_id = 5529) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2384));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('USA', 3)), 'USA', '🏳️', 2384 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2384);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Panama', 3)), 'Panama', '🏳️', 11 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 11);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-03-20', (SELECT id FROM teams WHERE api_id = 2384), (SELECT id FROM teams WHERE api_id = 11), 0, 1, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-03-20' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2384) AND away_team_id = (SELECT id FROM teams WHERE api_id = 11));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('USA', 3)), 'USA', '🏳️', 2384 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2384);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Jamaica', 3)), 'Jamaica', '🏳️', 2385 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2385);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-11-19', (SELECT id FROM teams WHERE api_id = 2384), (SELECT id FROM teams WHERE api_id = 2385), 4, 2, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-11-19' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2384) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2385));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Jamaica', 3)), 'Jamaica', '🏳️', 2385 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2385);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('USA', 3)), 'USA', '🏳️', 2384 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2384);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-11-15', (SELECT id FROM teams WHERE api_id = 2385), (SELECT id FROM teams WHERE api_id = 2384), 0, 1, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-11-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2385) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2384));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Mexico', 3)), 'Mexico', '🏳️', 16 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 16);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('USA', 3)), 'USA', '🏳️', 2384 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2384);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-10-16', (SELECT id FROM teams WHERE api_id = 16), (SELECT id FROM teams WHERE api_id = 2384), 2, 0, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-10-16' AND home_team_id = (SELECT id FROM teams WHERE api_id = 16) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2384));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Kosovo', 3)), 'Kosovo', '🏳️', 1111 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1111);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Türkiye', 3)), 'Türkiye', '🏳️', 777 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 777);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2026-03-31', (SELECT id FROM teams WHERE api_id = 1111), (SELECT id FROM teams WHERE api_id = 777), 0, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2026-03-31' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1111) AND away_team_id = (SELECT id FROM teams WHERE api_id = 777));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Türkiye', 3)), 'Türkiye', '🏳️', 777 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 777);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Romania', 3)), 'Romania', '🏳️', 774 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 774);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2026-03-26', (SELECT id FROM teams WHERE api_id = 777), (SELECT id FROM teams WHERE api_id = 774), 1, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2026-03-26' AND home_team_id = (SELECT id FROM teams WHERE api_id = 777) AND away_team_id = (SELECT id FROM teams WHERE api_id = 774));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Spain', 3)), 'Spain', '🏳️', 9 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 9);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Türkiye', 3)), 'Türkiye', '🏳️', 777 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 777);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-18', (SELECT id FROM teams WHERE api_id = 9), (SELECT id FROM teams WHERE api_id = 777), 2, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-18' AND home_team_id = (SELECT id FROM teams WHERE api_id = 9) AND away_team_id = (SELECT id FROM teams WHERE api_id = 777));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Türkiye', 3)), 'Türkiye', '🏳️', 777 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 777);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Bulgaria', 3)), 'Bulgaria', '🏳️', 1103 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1103);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-15', (SELECT id FROM teams WHERE api_id = 777), (SELECT id FROM teams WHERE api_id = 1103), 2, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 777) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1103));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Türkiye', 3)), 'Türkiye', '🏳️', 777 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 777);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Georgia', 3)), 'Georgia', '🏳️', 1104 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1104);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-14', (SELECT id FROM teams WHERE api_id = 777), (SELECT id FROM teams WHERE api_id = 1104), 4, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-14' AND home_team_id = (SELECT id FROM teams WHERE api_id = 777) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1104));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Bahrain', 3)), 'Bahrain', '🏳️', 1547 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1547);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Australia', 3)), 'Australia', '🏳️', 20 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 20);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-06', (SELECT id FROM teams WHERE api_id = 1547), (SELECT id FROM teams WHERE api_id = 20), 0, 2, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-06' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1547) AND away_team_id = (SELECT id FROM teams WHERE api_id = 20));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Costa Rica', 3)), 'Costa Rica', '🏳️', 29 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 29);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Paraguay', 3)), 'Paraguay', '🏳️', 2380 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2380);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-07-03', (SELECT id FROM teams WHERE api_id = 29), (SELECT id FROM teams WHERE api_id = 2380), 2, 1, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-07-03' AND home_team_id = (SELECT id FROM teams WHERE api_id = 29) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2380));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Paraguay', 3)), 'Paraguay', '🏳️', 2380 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2380);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Brazil', 3)), 'Brazil', '🏳️', 6 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 6);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-29', (SELECT id FROM teams WHERE api_id = 2380), (SELECT id FROM teams WHERE api_id = 6), 1, 4, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-29' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2380) AND away_team_id = (SELECT id FROM teams WHERE api_id = 6));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Colombia', 3)), 'Colombia', '🏳️', 8 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 8);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Paraguay', 3)), 'Paraguay', '🏳️', 2380 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2380);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-24', (SELECT id FROM teams WHERE api_id = 8), (SELECT id FROM teams WHERE api_id = 2380), 2, 1, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-24' AND home_team_id = (SELECT id FROM teams WHERE api_id = 8) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2380));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Panama', 3)), 'Panama', '🏳️', 11 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 11);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Paraguay', 3)), 'Paraguay', '🏳️', 2380 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2380);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-16', (SELECT id FROM teams WHERE api_id = 11), (SELECT id FROM teams WHERE api_id = 2380), 0, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-16' AND home_team_id = (SELECT id FROM teams WHERE api_id = 11) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2380));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Chile', 3)), 'Chile', '🏳️', 2383 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2383);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Paraguay', 3)), 'Paraguay', '🏳️', 2380 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2380);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-12', (SELECT id FROM teams WHERE api_id = 2383), (SELECT id FROM teams WHERE api_id = 2380), 3, 0, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-12' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2383) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2380));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Germany', 3)), 'Germany', '🏳️', 25 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 25);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Slovakia', 3)), 'Slovakia', '🏳️', 773 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 773);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-17', (SELECT id FROM teams WHERE api_id = 25), (SELECT id FROM teams WHERE api_id = 773), 6, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-17' AND home_team_id = (SELECT id FROM teams WHERE api_id = 25) AND away_team_id = (SELECT id FROM teams WHERE api_id = 773));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Luxembourg', 3)), 'Luxembourg', '🏳️', 1102 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1102);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Germany', 3)), 'Germany', '🏳️', 25 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 25);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-14', (SELECT id FROM teams WHERE api_id = 1102), (SELECT id FROM teams WHERE api_id = 25), 0, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-14' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1102) AND away_team_id = (SELECT id FROM teams WHERE api_id = 25));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Northern Ireland', 3)), 'Northern Ireland', '🏳️', 771 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 771);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Germany', 3)), 'Germany', '🏳️', 25 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 25);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-13', (SELECT id FROM teams WHERE api_id = 771), (SELECT id FROM teams WHERE api_id = 25), 0, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-13' AND home_team_id = (SELECT id FROM teams WHERE api_id = 771) AND away_team_id = (SELECT id FROM teams WHERE api_id = 25));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Germany', 3)), 'Germany', '🏳️', 25 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 25);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Luxembourg', 3)), 'Luxembourg', '🏳️', 1102 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1102);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-10', (SELECT id FROM teams WHERE api_id = 25), (SELECT id FROM teams WHERE api_id = 1102), 4, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-10' AND home_team_id = (SELECT id FROM teams WHERE api_id = 25) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1102));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Germany', 3)), 'Germany', '🏳️', 25 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 25);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Northern Ireland', 3)), 'Northern Ireland', '🏳️', 771 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 771);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-07', (SELECT id FROM teams WHERE api_id = 25), (SELECT id FROM teams WHERE api_id = 771), 3, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-07' AND home_team_id = (SELECT id FROM teams WHERE api_id = 25) AND away_team_id = (SELECT id FROM teams WHERE api_id = 771));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Mexico', 3)), 'Mexico', '🏳️', 16 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 16);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ecuador', 3)), 'Ecuador', '🏳️', 2382 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2382);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-07-01', (SELECT id FROM teams WHERE api_id = 16), (SELECT id FROM teams WHERE api_id = 2382), 0, 0, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-07-01' AND home_team_id = (SELECT id FROM teams WHERE api_id = 16) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2382));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ecuador', 3)), 'Ecuador', '🏳️', 2382 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2382);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Jamaica', 3)), 'Jamaica', '🏳️', 2385 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2385);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-27', (SELECT id FROM teams WHERE api_id = 2382), (SELECT id FROM teams WHERE api_id = 2385), 3, 1, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-27' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2382) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2385));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ecuador', 3)), 'Ecuador', '🏳️', 2382 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2382);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Venezuela', 3)), 'Venezuela', '🏳️', 2379 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2379);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-22', (SELECT id FROM teams WHERE api_id = 2382), (SELECT id FROM teams WHERE api_id = 2379), 1, 2, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-22' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2382) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2379));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ecuador', 3)), 'Ecuador', '🏳️', 2382 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2382);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Honduras', 3)), 'Honduras', '🏳️', 4672 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 4672);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-16', (SELECT id FROM teams WHERE api_id = 2382), (SELECT id FROM teams WHERE api_id = 4672), 2, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-16' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2382) AND away_team_id = (SELECT id FROM teams WHERE api_id = 4672));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ecuador', 3)), 'Ecuador', '🏳️', 2382 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2382);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Bolivia', 3)), 'Bolivia', '🏳️', 2381 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2381);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-13', (SELECT id FROM teams WHERE api_id = 2382), (SELECT id FROM teams WHERE api_id = 2381), 3, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-13' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2382) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2381));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ivory Coast', 3)), 'Ivory Coast', '🏳️', 1501 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1501);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Burkina Faso', 3)), 'Burkina Faso', '🏳️', 1502 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1502);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-22', (SELECT id FROM teams WHERE api_id = 1501), (SELECT id FROM teams WHERE api_id = 1502), 2, 0, 'African Nations Championship - Qualification', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-22' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1501) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1502));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ivory Coast', 3)), 'Ivory Coast', '🏳️', 1501 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1501);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Uruguay', 3)), 'Uruguay', '🏳️', 7 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 7);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-03-26', (SELECT id FROM teams WHERE api_id = 1501), (SELECT id FROM teams WHERE api_id = 7), 2, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-03-26' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1501) AND away_team_id = (SELECT id FROM teams WHERE api_id = 7));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ivory Coast', 3)), 'Ivory Coast', '🏳️', 1501 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1501);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Benin', 3)), 'Benin', '🏳️', 1516 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1516);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-03-23', (SELECT id FROM teams WHERE api_id = 1501), (SELECT id FROM teams WHERE api_id = 1516), 2, 2, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-03-23' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1501) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1516));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ivory Coast', 3)), 'Ivory Coast', '🏳️', 1501 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1501);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Sierra Leone', 3)), 'Sierra Leone', '🏳️', 1499 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1499);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-06', (SELECT id FROM teams WHERE api_id = 1501), (SELECT id FROM teams WHERE api_id = 1499), 5, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-06' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1501) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1499));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Curaçao', 3)), 'Curaçao', '🏳️', 5530 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5530);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('St. Lucia', 3)), 'St. Lucia', '🏳️', 5540 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5540);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-11-18', (SELECT id FROM teams WHERE api_id = 5530), (SELECT id FROM teams WHERE api_id = 5540), 4, 1, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-11-18' AND home_team_id = (SELECT id FROM teams WHERE api_id = 5530) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5540));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Saint Martin', 3)), 'Saint Martin', '🏳️', 10984 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 10984);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Curaçao', 3)), 'Curaçao', '🏳️', 5530 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5530);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-11-15', (SELECT id FROM teams WHERE api_id = 10984), (SELECT id FROM teams WHERE api_id = 5530), 0, 5, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-11-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 10984) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5530));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Curaçao', 3)), 'Curaçao', '🏳️', 5530 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5530);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Grenada', 3)), 'Grenada', '🏳️', 5533 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5533);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-10-14', (SELECT id FROM teams WHERE api_id = 5530), (SELECT id FROM teams WHERE api_id = 5533), 1, 0, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-10-14' AND home_team_id = (SELECT id FROM teams WHERE api_id = 5530) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5533));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Grenada', 3)), 'Grenada', '🏳️', 5533 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5533);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Curaçao', 3)), 'Curaçao', '🏳️', 5530 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5530);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-10-11', (SELECT id FROM teams WHERE api_id = 5533), (SELECT id FROM teams WHERE api_id = 5530), 0, 0, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-10-11' AND home_team_id = (SELECT id FROM teams WHERE api_id = 5533) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5530));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Curaçao', 3)), 'Curaçao', '🏳️', 5530 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5530);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Saint Martin', 3)), 'Saint Martin', '🏳️', 10984 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 10984);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-09-09', (SELECT id FROM teams WHERE api_id = 5530), (SELECT id FROM teams WHERE api_id = 10984), 4, 0, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-09-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 5530) AND away_team_id = (SELECT id FROM teams WHERE api_id = 10984));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Netherlands', 3)), 'Netherlands', '🏳️', 1118 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1118);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Lithuania', 3)), 'Lithuania', '🏳️', 1097 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1097);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-17', (SELECT id FROM teams WHERE api_id = 1118), (SELECT id FROM teams WHERE api_id = 1097), 4, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-17' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1118) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1097));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Poland', 3)), 'Poland', '🏳️', 24 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 24);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Netherlands', 3)), 'Netherlands', '🏳️', 1118 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1118);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-14', (SELECT id FROM teams WHERE api_id = 24), (SELECT id FROM teams WHERE api_id = 1118), 1, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-14' AND home_team_id = (SELECT id FROM teams WHERE api_id = 24) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1118));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Netherlands', 3)), 'Netherlands', '🏳️', 1118 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1118);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Finland', 3)), 'Finland', '🏳️', 1099 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1099);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-12', (SELECT id FROM teams WHERE api_id = 1118), (SELECT id FROM teams WHERE api_id = 1099), 4, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-12' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1118) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1099));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Malta', 3)), 'Malta', '🏳️', 1112 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1112);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Netherlands', 3)), 'Netherlands', '🏳️', 1118 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1118);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-09', (SELECT id FROM teams WHERE api_id = 1112), (SELECT id FROM teams WHERE api_id = 1118), 0, 4, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1112) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1118));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Lithuania', 3)), 'Lithuania', '🏳️', 1097 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1097);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Netherlands', 3)), 'Netherlands', '🏳️', 1118 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1118);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-07', (SELECT id FROM teams WHERE api_id = 1097), (SELECT id FROM teams WHERE api_id = 1118), 2, 3, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-07' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1097) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1118));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Japan', 3)), 'Japan', '🏳️', 12 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 12);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Jordan', 3)), 'Jordan', '🏳️', 1548 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1548);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-09', (SELECT id FROM teams WHERE api_id = 12), (SELECT id FROM teams WHERE api_id = 1548), 6, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 12) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1548));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Japan', 3)), 'Japan', '🏳️', 12 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 12);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Thailand', 3)), 'Thailand', '🏳️', 1564 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1564);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-01', (SELECT id FROM teams WHERE api_id = 12), (SELECT id FROM teams WHERE api_id = 1564), 5, 0, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-01' AND home_team_id = (SELECT id FROM teams WHERE api_id = 12) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1564));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Sweden', 3)), 'Sweden', '🏳️', 5 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Poland', 3)), 'Poland', '🏳️', 24 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 24);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2026-03-31', (SELECT id FROM teams WHERE api_id = 5), (SELECT id FROM teams WHERE api_id = 24), 3, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2026-03-31' AND home_team_id = (SELECT id FROM teams WHERE api_id = 5) AND away_team_id = (SELECT id FROM teams WHERE api_id = 24));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ukraine', 3)), 'Ukraine', '🏳️', 772 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 772);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Sweden', 3)), 'Sweden', '🏳️', 5 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2026-03-26', (SELECT id FROM teams WHERE api_id = 772), (SELECT id FROM teams WHERE api_id = 5), 1, 3, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2026-03-26' AND home_team_id = (SELECT id FROM teams WHERE api_id = 772) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Sweden', 3)), 'Sweden', '🏳️', 5 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Slovenia', 3)), 'Slovenia', '🏳️', 1091 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1091);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-18', (SELECT id FROM teams WHERE api_id = 5), (SELECT id FROM teams WHERE api_id = 1091), 1, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-18' AND home_team_id = (SELECT id FROM teams WHERE api_id = 5) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1091));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Switzerland', 3)), 'Switzerland', '🏳️', 15 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 15);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Sweden', 3)), 'Sweden', '🏳️', 5 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-15', (SELECT id FROM teams WHERE api_id = 15), (SELECT id FROM teams WHERE api_id = 5), 4, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 15) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Sweden', 3)), 'Sweden', '🏳️', 5 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Kosovo', 3)), 'Kosovo', '🏳️', 1111 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1111);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-13', (SELECT id FROM teams WHERE api_id = 5), (SELECT id FROM teams WHERE api_id = 1111), 0, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-13' AND home_team_id = (SELECT id FROM teams WHERE api_id = 5) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1111));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Tunisia', 3)), 'Tunisia', '🏳️', 28 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 28);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Cape Verde Islands', 3)), 'Cape Verde Islands', '🏳️', 1533 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1533);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-10', (SELECT id FROM teams WHERE api_id = 28), (SELECT id FROM teams WHERE api_id = 1533), 2, 0, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-10' AND home_team_id = (SELECT id FROM teams WHERE api_id = 28) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1533));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Tunisia', 3)), 'Tunisia', '🏳️', 28 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 28);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Mauritania', 3)), 'Mauritania', '🏳️', 1491 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1491);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-06', (SELECT id FROM teams WHERE api_id = 28), (SELECT id FROM teams WHERE api_id = 1491), 0, 0, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-06' AND home_team_id = (SELECT id FROM teams WHERE api_id = 28) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1491));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Belgium', 3)), 'Belgium', '🏳️', 1 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Liechtenstein', 3)), 'Liechtenstein', '🏳️', 1107 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1107);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-18', (SELECT id FROM teams WHERE api_id = 1), (SELECT id FROM teams WHERE api_id = 1107), 7, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-18' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1107));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Kazakhstan', 3)), 'Kazakhstan', '🏳️', 1095 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1095);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Belgium', 3)), 'Belgium', '🏳️', 1 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-15', (SELECT id FROM teams WHERE api_id = 1095), (SELECT id FROM teams WHERE api_id = 1), 1, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1095) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Wales', 3)), 'Wales', '🏳️', 767 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 767);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Belgium', 3)), 'Belgium', '🏳️', 1 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-13', (SELECT id FROM teams WHERE api_id = 767), (SELECT id FROM teams WHERE api_id = 1), 2, 4, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-13' AND home_team_id = (SELECT id FROM teams WHERE api_id = 767) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Belgium', 3)), 'Belgium', '🏳️', 1 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('FYR Macedonia', 3)), 'FYR Macedonia', '🏳️', 1105 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1105);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-10', (SELECT id FROM teams WHERE api_id = 1), (SELECT id FROM teams WHERE api_id = 1105), 0, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-10' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1105));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Belgium', 3)), 'Belgium', '🏳️', 1 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Kazakhstan', 3)), 'Kazakhstan', '🏳️', 1095 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1095);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-07', (SELECT id FROM teams WHERE api_id = 1), (SELECT id FROM teams WHERE api_id = 1095), 6, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-07' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1095));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Indonesia', 3)), 'Indonesia', '🏳️', 1571 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1571);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Iran', 3)), 'Iran', '🏳️', 22 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 22);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-09', (SELECT id FROM teams WHERE api_id = 1571), (SELECT id FROM teams WHERE api_id = 22), 0, 5, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1571) AND away_team_id = (SELECT id FROM teams WHERE api_id = 22));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Iran', 3)), 'Iran', '🏳️', 22 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 22);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Burkina Faso', 3)), 'Burkina Faso', '🏳️', 1502 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1502);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-05', (SELECT id FROM teams WHERE api_id = 22), (SELECT id FROM teams WHERE api_id = 1502), 2, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-05' AND home_team_id = (SELECT id FROM teams WHERE api_id = 22) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1502));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Egypt', 3)), 'Egypt', '🏳️', 32 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 32);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('South Africa', 3)), 'South Africa', '🏳️', 1531 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1531);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-03-09', (SELECT id FROM teams WHERE api_id = 32), (SELECT id FROM teams WHERE api_id = 1531), 1, 3, 'African Nations Championship - Qualification', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-03-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 32) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1531));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('South Africa', 3)), 'South Africa', '🏳️', 1531 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1531);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Egypt', 3)), 'Egypt', '🏳️', 32 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 32);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-03-02', (SELECT id FROM teams WHERE api_id = 1531), (SELECT id FROM teams WHERE api_id = 32), 1, 1, 'African Nations Championship - Qualification', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-03-02' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1531) AND away_team_id = (SELECT id FROM teams WHERE api_id = 32));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Egypt', 3)), 'Egypt', '🏳️', 32 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 32);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Croatia', 3)), 'Croatia', '🏳️', 3 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 3);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-03-26', (SELECT id FROM teams WHERE api_id = 32), (SELECT id FROM teams WHERE api_id = 3), 2, 4, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-03-26' AND home_team_id = (SELECT id FROM teams WHERE api_id = 32) AND away_team_id = (SELECT id FROM teams WHERE api_id = 3));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Egypt', 3)), 'Egypt', '🏳️', 32 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 32);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('New Zealand', 3)), 'New Zealand', '🏳️', 4673 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 4673);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-03-22', (SELECT id FROM teams WHERE api_id = 32), (SELECT id FROM teams WHERE api_id = 4673), 1, 0, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-03-22' AND home_team_id = (SELECT id FROM teams WHERE api_id = 32) AND away_team_id = (SELECT id FROM teams WHERE api_id = 4673));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Egypt', 3)), 'Egypt', '🏳️', 32 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 32);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Tanzania', 3)), 'Tanzania', '🏳️', 1489 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1489);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-07', (SELECT id FROM teams WHERE api_id = 32), (SELECT id FROM teams WHERE api_id = 1489), 2, 0, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-07' AND home_team_id = (SELECT id FROM teams WHERE api_id = 32) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1489));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('New Zealand', 3)), 'New Zealand', '🏳️', 4673 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 4673);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Malaysia', 3)), 'Malaysia', '🏳️', 1538 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1538);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-10-14', (SELECT id FROM teams WHERE api_id = 4673), (SELECT id FROM teams WHERE api_id = 1538), 4, 0, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-10-14' AND home_team_id = (SELECT id FROM teams WHERE api_id = 4673) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1538));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('USA', 3)), 'USA', '🏳️', 2384 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2384);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('New Zealand', 3)), 'New Zealand', '🏳️', 4673 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 4673);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-09-10', (SELECT id FROM teams WHERE api_id = 2384), (SELECT id FROM teams WHERE api_id = 4673), 1, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-09-10' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2384) AND away_team_id = (SELECT id FROM teams WHERE api_id = 4673));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Mexico', 3)), 'Mexico', '🏳️', 16 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 16);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('New Zealand', 3)), 'New Zealand', '🏳️', 4673 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 4673);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-09-08', (SELECT id FROM teams WHERE api_id = 16), (SELECT id FROM teams WHERE api_id = 4673), 3, 0, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-09-08' AND home_team_id = (SELECT id FROM teams WHERE api_id = 16) AND away_team_id = (SELECT id FROM teams WHERE api_id = 4673));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('New Zealand', 3)), 'New Zealand', '🏳️', 4673 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 4673);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Vanuatu', 3)), 'Vanuatu', '🏳️', 5170 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5170);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-30', (SELECT id FROM teams WHERE api_id = 4673), (SELECT id FROM teams WHERE api_id = 5170), 3, 0, 'OFC Nations Cup', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-30' AND home_team_id = (SELECT id FROM teams WHERE api_id = 4673) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5170));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('New Zealand', 3)), 'New Zealand', '🏳️', 4673 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 4673);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Tahiti', 3)), 'Tahiti', '🏳️', 5167 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5167);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-27', (SELECT id FROM teams WHERE api_id = 4673), (SELECT id FROM teams WHERE api_id = 5167), 5, 0, 'OFC Nations Cup', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-27' AND home_team_id = (SELECT id FROM teams WHERE api_id = 4673) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5167));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Spain', 3)), 'Spain', '🏳️', 9 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 9);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Türkiye', 3)), 'Türkiye', '🏳️', 777 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 777);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-18', (SELECT id FROM teams WHERE api_id = 9), (SELECT id FROM teams WHERE api_id = 777), 2, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-18' AND home_team_id = (SELECT id FROM teams WHERE api_id = 9) AND away_team_id = (SELECT id FROM teams WHERE api_id = 777));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Georgia', 3)), 'Georgia', '🏳️', 1104 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1104);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Spain', 3)), 'Spain', '🏳️', 9 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 9);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-15', (SELECT id FROM teams WHERE api_id = 1104), (SELECT id FROM teams WHERE api_id = 9), 0, 4, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1104) AND away_team_id = (SELECT id FROM teams WHERE api_id = 9));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Spain', 3)), 'Spain', '🏳️', 9 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 9);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Bulgaria', 3)), 'Bulgaria', '🏳️', 1103 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1103);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-14', (SELECT id FROM teams WHERE api_id = 9), (SELECT id FROM teams WHERE api_id = 1103), 4, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-14' AND home_team_id = (SELECT id FROM teams WHERE api_id = 9) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1103));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Spain', 3)), 'Spain', '🏳️', 9 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 9);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Georgia', 3)), 'Georgia', '🏳️', 1104 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1104);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-11', (SELECT id FROM teams WHERE api_id = 9), (SELECT id FROM teams WHERE api_id = 1104), 2, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-11' AND home_team_id = (SELECT id FROM teams WHERE api_id = 9) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1104));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Türkiye', 3)), 'Türkiye', '🏳️', 777 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 777);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Spain', 3)), 'Spain', '🏳️', 9 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 9);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-07', (SELECT id FROM teams WHERE api_id = 777), (SELECT id FROM teams WHERE api_id = 9), 0, 6, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-07' AND home_team_id = (SELECT id FROM teams WHERE api_id = 777) AND away_team_id = (SELECT id FROM teams WHERE api_id = 9));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Uruguay', 3)), 'Uruguay', '🏳️', 7 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 7);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Guatemala', 3)), 'Guatemala', '🏳️', 5161 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5161);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-09-01', (SELECT id FROM teams WHERE api_id = 7), (SELECT id FROM teams WHERE api_id = 5161), 1, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-09-01' AND home_team_id = (SELECT id FROM teams WHERE api_id = 7) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5161));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Uruguay', 3)), 'Uruguay', '🏳️', 7 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 7);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Colombia', 3)), 'Colombia', '🏳️', 8 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 8);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-07-11', (SELECT id FROM teams WHERE api_id = 7), (SELECT id FROM teams WHERE api_id = 8), 0, 1, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-07-11' AND home_team_id = (SELECT id FROM teams WHERE api_id = 7) AND away_team_id = (SELECT id FROM teams WHERE api_id = 8));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('USA', 3)), 'USA', '🏳️', 2384 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2384);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Uruguay', 3)), 'Uruguay', '🏳️', 7 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 7);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-07-02', (SELECT id FROM teams WHERE api_id = 2384), (SELECT id FROM teams WHERE api_id = 7), 0, 1, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-07-02' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2384) AND away_team_id = (SELECT id FROM teams WHERE api_id = 7));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Uruguay', 3)), 'Uruguay', '🏳️', 7 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 7);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Bolivia', 3)), 'Bolivia', '🏳️', 2381 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2381);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-28', (SELECT id FROM teams WHERE api_id = 7), (SELECT id FROM teams WHERE api_id = 2381), 5, 0, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-28' AND home_team_id = (SELECT id FROM teams WHERE api_id = 7) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2381));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Uruguay', 3)), 'Uruguay', '🏳️', 7 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 7);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Panama', 3)), 'Panama', '🏳️', 11 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 11);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-24', (SELECT id FROM teams WHERE api_id = 7), (SELECT id FROM teams WHERE api_id = 11), 3, 1, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-24' AND home_team_id = (SELECT id FROM teams WHERE api_id = 7) AND away_team_id = (SELECT id FROM teams WHERE api_id = 11));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Oman', 3)), 'Oman', '🏳️', 1552 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1552);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Saudi Arabia', 3)), 'Saudi Arabia', '🏳️', 23 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 23);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-31', (SELECT id FROM teams WHERE api_id = 1552), (SELECT id FROM teams WHERE api_id = 23), 2, 1, 'Gulf Cup of Nations', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-31' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1552) AND away_team_id = (SELECT id FROM teams WHERE api_id = 23));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Iraq', 3)), 'Iraq', '🏳️', 1567 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1567);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Saudi Arabia', 3)), 'Saudi Arabia', '🏳️', 23 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 23);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-28', (SELECT id FROM teams WHERE api_id = 1567), (SELECT id FROM teams WHERE api_id = 23), 1, 3, 'Gulf Cup of Nations', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-28' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1567) AND away_team_id = (SELECT id FROM teams WHERE api_id = 23));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Yemen', 3)), 'Yemen', '🏳️', 1550 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1550);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Saudi Arabia', 3)), 'Saudi Arabia', '🏳️', 23 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 23);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-25', (SELECT id FROM teams WHERE api_id = 1550), (SELECT id FROM teams WHERE api_id = 23), 2, 3, 'Gulf Cup of Nations', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-25' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1550) AND away_team_id = (SELECT id FROM teams WHERE api_id = 23));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Saudi Arabia', 3)), 'Saudi Arabia', '🏳️', 23 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 23);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Bahrain', 3)), 'Bahrain', '🏳️', 1547 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1547);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-22', (SELECT id FROM teams WHERE api_id = 23), (SELECT id FROM teams WHERE api_id = 1547), 2, 3, 'Gulf Cup of Nations', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-22' AND home_team_id = (SELECT id FROM teams WHERE api_id = 23) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1547));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Saudi Arabia', 3)), 'Saudi Arabia', '🏳️', 23 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 23);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Trinidad and Tobago', 3)), 'Trinidad and Tobago', '🏳️', 5168 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5168);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-17', (SELECT id FROM teams WHERE api_id = 23), (SELECT id FROM teams WHERE api_id = 5168), 3, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-17' AND home_team_id = (SELECT id FROM teams WHERE api_id = 23) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5168));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Cape Verde Islands', 3)), 'Cape Verde Islands', '🏳️', 1533 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1533);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Equatorial Guinea', 3)), 'Equatorial Guinea', '🏳️', 1521 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1521);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-03-25', (SELECT id FROM teams WHERE api_id = 1533), (SELECT id FROM teams WHERE api_id = 1521), 1, 0, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-03-25' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1533) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1521));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Cape Verde Islands', 3)), 'Cape Verde Islands', '🏳️', 1533 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1533);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Guyana', 3)), 'Guyana', '🏳️', 5162 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5162);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-03-21', (SELECT id FROM teams WHERE api_id = 1533), (SELECT id FROM teams WHERE api_id = 5162), 1, 0, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-03-21' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1533) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5162));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Tunisia', 3)), 'Tunisia', '🏳️', 28 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 28);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Cape Verde Islands', 3)), 'Cape Verde Islands', '🏳️', 1533 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1533);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-10', (SELECT id FROM teams WHERE api_id = 28), (SELECT id FROM teams WHERE api_id = 1533), 2, 0, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-10' AND home_team_id = (SELECT id FROM teams WHERE api_id = 28) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1533));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Azerbaijan', 3)), 'Azerbaijan', '🏳️', 1096 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1096);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('France', 3)), 'France', '🏳️', 2 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-16', (SELECT id FROM teams WHERE api_id = 1096), (SELECT id FROM teams WHERE api_id = 2), 1, 3, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-16' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1096) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('France', 3)), 'France', '🏳️', 2 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ukraine', 3)), 'Ukraine', '🏳️', 772 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 772);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-13', (SELECT id FROM teams WHERE api_id = 2), (SELECT id FROM teams WHERE api_id = 772), 4, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-13' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2) AND away_team_id = (SELECT id FROM teams WHERE api_id = 772));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Iceland', 3)), 'Iceland', '🏳️', 18 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 18);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('France', 3)), 'France', '🏳️', 2 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-13', (SELECT id FROM teams WHERE api_id = 18), (SELECT id FROM teams WHERE api_id = 2), 2, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-13' AND home_team_id = (SELECT id FROM teams WHERE api_id = 18) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('France', 3)), 'France', '🏳️', 2 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Azerbaijan', 3)), 'Azerbaijan', '🏳️', 1096 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1096);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-10', (SELECT id FROM teams WHERE api_id = 2), (SELECT id FROM teams WHERE api_id = 1096), 3, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-10' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1096));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('France', 3)), 'France', '🏳️', 2 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Iceland', 3)), 'Iceland', '🏳️', 18 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 18);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-09', (SELECT id FROM teams WHERE api_id = 2), (SELECT id FROM teams WHERE api_id = 18), 2, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2) AND away_team_id = (SELECT id FROM teams WHERE api_id = 18));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Uganda', 3)), 'Uganda', '🏳️', 1519 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1519);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Senegal', 3)), 'Senegal', '🏳️', 13 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 13);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-23', (SELECT id FROM teams WHERE api_id = 1519), (SELECT id FROM teams WHERE api_id = 13), 0, 1, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-23' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1519) AND away_team_id = (SELECT id FROM teams WHERE api_id = 13));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Sudan', 3)), 'Sudan', '🏳️', 1510 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1510);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Senegal', 3)), 'Senegal', '🏳️', 13 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 13);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-19', (SELECT id FROM teams WHERE api_id = 1510), (SELECT id FROM teams WHERE api_id = 13), 0, 0, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-19' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1510) AND away_team_id = (SELECT id FROM teams WHERE api_id = 13));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Senegal', 3)), 'Senegal', '🏳️', 13 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 13);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Congo', 3)), 'Congo', '🏳️', 1517 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1517);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-12', (SELECT id FROM teams WHERE api_id = 13), (SELECT id FROM teams WHERE api_id = 1517), 1, 1, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-12' AND home_team_id = (SELECT id FROM teams WHERE api_id = 13) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1517));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Senegal', 3)), 'Senegal', '🏳️', 13 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 13);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Nigeria', 3)), 'Nigeria', '🏳️', 19 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 19);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-05', (SELECT id FROM teams WHERE api_id = 13), (SELECT id FROM teams WHERE api_id = 19), 1, 0, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-05' AND home_team_id = (SELECT id FROM teams WHERE api_id = 13) AND away_team_id = (SELECT id FROM teams WHERE api_id = 19));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Senegal', 3)), 'Senegal', '🏳️', 13 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 13);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Liberia', 3)), 'Liberia', '🏳️', 1525 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1525);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-28', (SELECT id FROM teams WHERE api_id = 13), (SELECT id FROM teams WHERE api_id = 1525), 3, 0, 'African Nations Championship - Qualification', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-28' AND home_team_id = (SELECT id FROM teams WHERE api_id = 13) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1525));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Italy', 3)), 'Italy', '🏳️', 768 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 768);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Norway', 3)), 'Norway', '🏳️', 1090 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1090);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-16', (SELECT id FROM teams WHERE api_id = 768), (SELECT id FROM teams WHERE api_id = 1090), 1, 4, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-16' AND home_team_id = (SELECT id FROM teams WHERE api_id = 768) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1090));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Norway', 3)), 'Norway', '🏳️', 1090 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1090);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Estonia', 3)), 'Estonia', '🏳️', 1101 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1101);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-13', (SELECT id FROM teams WHERE api_id = 1090), (SELECT id FROM teams WHERE api_id = 1101), 4, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-13' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1090) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1101));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Norway', 3)), 'Norway', '🏳️', 1090 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1090);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Israel', 3)), 'Israel', '🏳️', 1116 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1116);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-11', (SELECT id FROM teams WHERE api_id = 1090), (SELECT id FROM teams WHERE api_id = 1116), 5, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-11' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1090) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1116));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Norway', 3)), 'Norway', '🏳️', 1090 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1090);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Moldova', 3)), 'Moldova', '🏳️', 1114 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1114);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-09', (SELECT id FROM teams WHERE api_id = 1090), (SELECT id FROM teams WHERE api_id = 1114), 11, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1090) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1114));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Estonia', 3)), 'Estonia', '🏳️', 1101 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1101);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Norway', 3)), 'Norway', '🏳️', 1090 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1090);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-06-09', (SELECT id FROM teams WHERE api_id = 1101), (SELECT id FROM teams WHERE api_id = 1090), 0, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-06-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1101) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1090));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Iraq', 3)), 'Iraq', '🏳️', 1567 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1567);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Saudi Arabia', 3)), 'Saudi Arabia', '🏳️', 23 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 23);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-28', (SELECT id FROM teams WHERE api_id = 1567), (SELECT id FROM teams WHERE api_id = 23), 1, 3, 'Gulf Cup of Nations', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-28' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1567) AND away_team_id = (SELECT id FROM teams WHERE api_id = 23));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Bahrain', 3)), 'Bahrain', '🏳️', 1547 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1547);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Iraq', 3)), 'Iraq', '🏳️', 1567 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1567);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-25', (SELECT id FROM teams WHERE api_id = 1547), (SELECT id FROM teams WHERE api_id = 1567), 2, 0, 'Gulf Cup of Nations', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-25' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1547) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1567));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Iraq', 3)), 'Iraq', '🏳️', 1567 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1567);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Yemen', 3)), 'Yemen', '🏳️', 1550 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1550);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-22', (SELECT id FROM teams WHERE api_id = 1567), (SELECT id FROM teams WHERE api_id = 1550), 1, 0, 'Gulf Cup of Nations', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-22' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1567) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1550));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Iraq', 3)), 'Iraq', '🏳️', 1567 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1567);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('South Korea', 3)), 'South Korea', '🏳️', 17 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 17);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-06', (SELECT id FROM teams WHERE api_id = 1567), (SELECT id FROM teams WHERE api_id = 17), 0, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-06' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1567) AND away_team_id = (SELECT id FROM teams WHERE api_id = 17));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Argentina', 3)), 'Argentina', '🏳️', 26 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 26);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Canada', 3)), 'Canada', '🏳️', 5529 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5529);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-07-10', (SELECT id FROM teams WHERE api_id = 26), (SELECT id FROM teams WHERE api_id = 5529), 2, 0, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-07-10' AND home_team_id = (SELECT id FROM teams WHERE api_id = 26) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5529));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Argentina', 3)), 'Argentina', '🏳️', 26 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 26);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Peru', 3)), 'Peru', '🏳️', 30 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 30);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-30', (SELECT id FROM teams WHERE api_id = 26), (SELECT id FROM teams WHERE api_id = 30), 2, 0, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-30' AND home_team_id = (SELECT id FROM teams WHERE api_id = 26) AND away_team_id = (SELECT id FROM teams WHERE api_id = 30));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Chile', 3)), 'Chile', '🏳️', 2383 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2383);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Argentina', 3)), 'Argentina', '🏳️', 26 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 26);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-26', (SELECT id FROM teams WHERE api_id = 2383), (SELECT id FROM teams WHERE api_id = 26), 0, 1, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-26' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2383) AND away_team_id = (SELECT id FROM teams WHERE api_id = 26));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Argentina', 3)), 'Argentina', '🏳️', 26 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 26);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Canada', 3)), 'Canada', '🏳️', 5529 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5529);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-21', (SELECT id FROM teams WHERE api_id = 26), (SELECT id FROM teams WHERE api_id = 5529), 2, 0, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-21' AND home_team_id = (SELECT id FROM teams WHERE api_id = 26) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5529));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Argentina', 3)), 'Argentina', '🏳️', 26 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 26);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Guatemala', 3)), 'Guatemala', '🏳️', 5161 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5161);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-15', (SELECT id FROM teams WHERE api_id = 26), (SELECT id FROM teams WHERE api_id = 5161), 4, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 26) AND away_team_id = (SELECT id FROM teams WHERE api_id = 5161));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Austria', 3)), 'Austria', '🏳️', 775 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 775);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Bosnia & Herzegovina', 3)), 'Bosnia & Herzegovina', '🏳️', 1113 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1113);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-18', (SELECT id FROM teams WHERE api_id = 775), (SELECT id FROM teams WHERE api_id = 1113), 1, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-18' AND home_team_id = (SELECT id FROM teams WHERE api_id = 775) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1113));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Cyprus', 3)), 'Cyprus', '🏳️', 1106 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1106);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Austria', 3)), 'Austria', '🏳️', 775 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 775);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-15', (SELECT id FROM teams WHERE api_id = 1106), (SELECT id FROM teams WHERE api_id = 775), 0, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1106) AND away_team_id = (SELECT id FROM teams WHERE api_id = 775));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Romania', 3)), 'Romania', '🏳️', 774 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 774);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Austria', 3)), 'Austria', '🏳️', 775 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 775);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-12', (SELECT id FROM teams WHERE api_id = 774), (SELECT id FROM teams WHERE api_id = 775), 1, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-12' AND home_team_id = (SELECT id FROM teams WHERE api_id = 774) AND away_team_id = (SELECT id FROM teams WHERE api_id = 775));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Austria', 3)), 'Austria', '🏳️', 775 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 775);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('San Marino', 3)), 'San Marino', '🏳️', 1115 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1115);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-09', (SELECT id FROM teams WHERE api_id = 775), (SELECT id FROM teams WHERE api_id = 1115), 10, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 775) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1115));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Bosnia & Herzegovina', 3)), 'Bosnia & Herzegovina', '🏳️', 1113 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1113);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Austria', 3)), 'Austria', '🏳️', 775 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 775);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-09', (SELECT id FROM teams WHERE api_id = 1113), (SELECT id FROM teams WHERE api_id = 775), 1, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1113) AND away_team_id = (SELECT id FROM teams WHERE api_id = 775));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Algeria', 3)), 'Algeria', '🏳️', 1532 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1532);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Niger', 3)), 'Niger', '🏳️', 1505 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1505);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-18', (SELECT id FROM teams WHERE api_id = 1532), (SELECT id FROM teams WHERE api_id = 1505), 0, 0, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-18' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1532) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1505));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Guinea', 3)), 'Guinea', '🏳️', 1509 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1509);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Algeria', 3)), 'Algeria', '🏳️', 1532 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1532);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-15', (SELECT id FROM teams WHERE api_id = 1509), (SELECT id FROM teams WHERE api_id = 1532), 1, 1, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1509) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1532));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Algeria', 3)), 'Algeria', '🏳️', 1532 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1532);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('South Africa', 3)), 'South Africa', '🏳️', 1531 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1531);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-08', (SELECT id FROM teams WHERE api_id = 1532), (SELECT id FROM teams WHERE api_id = 1531), 1, 1, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-08' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1532) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1531));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Uganda', 3)), 'Uganda', '🏳️', 1519 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1519);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Algeria', 3)), 'Algeria', '🏳️', 1532 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1532);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-04', (SELECT id FROM teams WHERE api_id = 1519), (SELECT id FROM teams WHERE api_id = 1532), 0, 3, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-04' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1519) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1532));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Algeria', 3)), 'Algeria', '🏳️', 1532 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1532);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Gambia', 3)), 'Gambia', '🏳️', 1492 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1492);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-05-09', (SELECT id FROM teams WHERE api_id = 1532), (SELECT id FROM teams WHERE api_id = 1492), 3, 0, 'African Nations Championship - Qualification', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-05-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1532) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1492));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Jordan', 3)), 'Jordan', '🏳️', 1548 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1548);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('North Korea', 3)), 'North Korea', '🏳️', 1561 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1561);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-08-29', (SELECT id FROM teams WHERE api_id = 1548), (SELECT id FROM teams WHERE api_id = 1561), 2, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-08-29' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1548) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1561));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Jordan', 3)), 'Jordan', '🏳️', 1548 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1548);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('North Korea', 3)), 'North Korea', '🏳️', 1561 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1561);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-08-27', (SELECT id FROM teams WHERE api_id = 1548), (SELECT id FROM teams WHERE api_id = 1561), 0, 0, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-08-27' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1548) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1561));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Japan', 3)), 'Japan', '🏳️', 12 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 12);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Jordan', 3)), 'Jordan', '🏳️', 1548 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1548);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-09', (SELECT id FROM teams WHERE api_id = 12), (SELECT id FROM teams WHERE api_id = 1548), 6, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 12) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1548));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Qatar', 3)), 'Qatar', '🏳️', 1569 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1569);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Jordan', 3)), 'Jordan', '🏳️', 1548 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1548);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-05', (SELECT id FROM teams WHERE api_id = 1569), (SELECT id FROM teams WHERE api_id = 1548), 1, 2, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-05' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1569) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1548));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Portugal', 3)), 'Portugal', '🏳️', 27 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 27);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Armenia', 3)), 'Armenia', '🏳️', 1094 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1094);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-16', (SELECT id FROM teams WHERE api_id = 27), (SELECT id FROM teams WHERE api_id = 1094), 9, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-16' AND home_team_id = (SELECT id FROM teams WHERE api_id = 27) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1094));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Rep. Of Ireland', 3)), 'Rep. Of Ireland', '🏳️', 776 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 776);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Portugal', 3)), 'Portugal', '🏳️', 27 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 27);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-13', (SELECT id FROM teams WHERE api_id = 776), (SELECT id FROM teams WHERE api_id = 27), 2, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-13' AND home_team_id = (SELECT id FROM teams WHERE api_id = 776) AND away_team_id = (SELECT id FROM teams WHERE api_id = 27));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Portugal', 3)), 'Portugal', '🏳️', 27 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 27);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Hungary', 3)), 'Hungary', '🏳️', 769 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 769);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-14', (SELECT id FROM teams WHERE api_id = 27), (SELECT id FROM teams WHERE api_id = 769), 2, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-14' AND home_team_id = (SELECT id FROM teams WHERE api_id = 27) AND away_team_id = (SELECT id FROM teams WHERE api_id = 769));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Portugal', 3)), 'Portugal', '🏳️', 27 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 27);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Rep. Of Ireland', 3)), 'Rep. Of Ireland', '🏳️', 776 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 776);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-11', (SELECT id FROM teams WHERE api_id = 27), (SELECT id FROM teams WHERE api_id = 776), 1, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-11' AND home_team_id = (SELECT id FROM teams WHERE api_id = 27) AND away_team_id = (SELECT id FROM teams WHERE api_id = 776));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Hungary', 3)), 'Hungary', '🏳️', 769 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 769);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Portugal', 3)), 'Portugal', '🏳️', 27 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 27);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-09', (SELECT id FROM teams WHERE api_id = 769), (SELECT id FROM teams WHERE api_id = 27), 2, 3, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 769) AND away_team_id = (SELECT id FROM teams WHERE api_id = 27));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Uruguay', 3)), 'Uruguay', '🏳️', 7 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 7);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Colombia', 3)), 'Colombia', '🏳️', 8 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 8);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-07-11', (SELECT id FROM teams WHERE api_id = 7), (SELECT id FROM teams WHERE api_id = 8), 0, 1, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-07-11' AND home_team_id = (SELECT id FROM teams WHERE api_id = 7) AND away_team_id = (SELECT id FROM teams WHERE api_id = 8));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Colombia', 3)), 'Colombia', '🏳️', 8 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 8);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Panama', 3)), 'Panama', '🏳️', 11 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 11);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-07-06', (SELECT id FROM teams WHERE api_id = 8), (SELECT id FROM teams WHERE api_id = 11), 5, 0, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-07-06' AND home_team_id = (SELECT id FROM teams WHERE api_id = 8) AND away_team_id = (SELECT id FROM teams WHERE api_id = 11));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Brazil', 3)), 'Brazil', '🏳️', 6 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 6);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Colombia', 3)), 'Colombia', '🏳️', 8 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 8);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-07-03', (SELECT id FROM teams WHERE api_id = 6), (SELECT id FROM teams WHERE api_id = 8), 1, 1, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-07-03' AND home_team_id = (SELECT id FROM teams WHERE api_id = 6) AND away_team_id = (SELECT id FROM teams WHERE api_id = 8));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Colombia', 3)), 'Colombia', '🏳️', 8 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 8);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Costa Rica', 3)), 'Costa Rica', '🏳️', 29 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 29);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-29', (SELECT id FROM teams WHERE api_id = 8), (SELECT id FROM teams WHERE api_id = 29), 3, 0, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-29' AND home_team_id = (SELECT id FROM teams WHERE api_id = 8) AND away_team_id = (SELECT id FROM teams WHERE api_id = 29));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Colombia', 3)), 'Colombia', '🏳️', 8 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 8);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Paraguay', 3)), 'Paraguay', '🏳️', 2380 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2380);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-06-24', (SELECT id FROM teams WHERE api_id = 8), (SELECT id FROM teams WHERE api_id = 2380), 2, 1, 'Copa America', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-06-24' AND home_team_id = (SELECT id FROM teams WHERE api_id = 8) AND away_team_id = (SELECT id FROM teams WHERE api_id = 2380));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Palestine', 3)), 'Palestine', '🏳️', 1562 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1562);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Uzbekistan', 3)), 'Uzbekistan', '🏳️', 1568 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1568);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-07', (SELECT id FROM teams WHERE api_id = 1562), (SELECT id FROM teams WHERE api_id = 1568), 0, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-07' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1562) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1568));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Congo DR', 3)), 'Congo DR', '🏳️', 1508 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1508);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Morocco', 3)), 'Morocco', '🏳️', 31 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 31);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-17', (SELECT id FROM teams WHERE api_id = 1508), (SELECT id FROM teams WHERE api_id = 31), 1, 3, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-17' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1508) AND away_team_id = (SELECT id FROM teams WHERE api_id = 31));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Angola', 3)), 'Angola', '🏳️', 1529 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1529);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Congo DR', 3)), 'Congo DR', '🏳️', 1508 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1508);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-14', (SELECT id FROM teams WHERE api_id = 1529), (SELECT id FROM teams WHERE api_id = 1508), 0, 2, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-14' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1529) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1508));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Congo DR', 3)), 'Congo DR', '🏳️', 1508 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1508);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Zambia', 3)), 'Zambia', '🏳️', 1507 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1507);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-07', (SELECT id FROM teams WHERE api_id = 1508), (SELECT id FROM teams WHERE api_id = 1507), 2, 0, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-07' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1508) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1507));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Kenya', 3)), 'Kenya', '🏳️', 1511 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1511);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Congo DR', 3)), 'Congo DR', '🏳️', 1508 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1508);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-08-03', (SELECT id FROM teams WHERE api_id = 1511), (SELECT id FROM teams WHERE api_id = 1508), 1, 0, 'African Nations Championship', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-08-03' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1511) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1508));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Congo DR', 3)), 'Congo DR', '🏳️', 1508 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1508);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Chad', 3)), 'Chad', '🏳️', 1523 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1523);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-28', (SELECT id FROM teams WHERE api_id = 1508), (SELECT id FROM teams WHERE api_id = 1523), 3, 1, 'African Nations Championship - Qualification', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-28' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1508) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1523));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Albania', 3)), 'Albania', '🏳️', 778 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 778);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('England', 3)), 'England', '🏳️', 10 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 10);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-16', (SELECT id FROM teams WHERE api_id = 778), (SELECT id FROM teams WHERE api_id = 10), 0, 2, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-16' AND home_team_id = (SELECT id FROM teams WHERE api_id = 778) AND away_team_id = (SELECT id FROM teams WHERE api_id = 10));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('England', 3)), 'England', '🏳️', 10 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 10);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Serbia', 3)), 'Serbia', '🏳️', 14 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 14);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-13', (SELECT id FROM teams WHERE api_id = 10), (SELECT id FROM teams WHERE api_id = 14), 2, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-13' AND home_team_id = (SELECT id FROM teams WHERE api_id = 10) AND away_team_id = (SELECT id FROM teams WHERE api_id = 14));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Latvia', 3)), 'Latvia', '🏳️', 1092 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1092);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('England', 3)), 'England', '🏳️', 10 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 10);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-14', (SELECT id FROM teams WHERE api_id = 1092), (SELECT id FROM teams WHERE api_id = 10), 0, 5, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-14' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1092) AND away_team_id = (SELECT id FROM teams WHERE api_id = 10));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Serbia', 3)), 'Serbia', '🏳️', 14 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 14);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('England', 3)), 'England', '🏳️', 10 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 10);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-09', (SELECT id FROM teams WHERE api_id = 14), (SELECT id FROM teams WHERE api_id = 10), 0, 5, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 14) AND away_team_id = (SELECT id FROM teams WHERE api_id = 10));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('England', 3)), 'England', '🏳️', 10 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 10);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Andorra', 3)), 'Andorra', '🏳️', 1110 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1110);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-06', (SELECT id FROM teams WHERE api_id = 10), (SELECT id FROM teams WHERE api_id = 1110), 2, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-06' AND home_team_id = (SELECT id FROM teams WHERE api_id = 10) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1110));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Montenegro', 3)), 'Montenegro', '🏳️', 1109 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1109);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Croatia', 3)), 'Croatia', '🏳️', 3 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 3);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-17', (SELECT id FROM teams WHERE api_id = 1109), (SELECT id FROM teams WHERE api_id = 3), 2, 3, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-17' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1109) AND away_team_id = (SELECT id FROM teams WHERE api_id = 3));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Croatia', 3)), 'Croatia', '🏳️', 3 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 3);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Faroe Islands', 3)), 'Faroe Islands', '🏳️', 1098 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1098);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-11-14', (SELECT id FROM teams WHERE api_id = 3), (SELECT id FROM teams WHERE api_id = 1098), 3, 1, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-11-14' AND home_team_id = (SELECT id FROM teams WHERE api_id = 3) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1098));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Croatia', 3)), 'Croatia', '🏳️', 3 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 3);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Gibraltar', 3)), 'Gibraltar', '🏳️', 1093 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1093);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-12', (SELECT id FROM teams WHERE api_id = 3), (SELECT id FROM teams WHERE api_id = 1093), 3, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-12' AND home_team_id = (SELECT id FROM teams WHERE api_id = 3) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1093));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Czechia', 3)), 'Czechia', '🏳️', 770 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 770);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Croatia', 3)), 'Croatia', '🏳️', 3 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 3);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-10-09', (SELECT id FROM teams WHERE api_id = 770), (SELECT id FROM teams WHERE api_id = 3), 0, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-10-09' AND home_team_id = (SELECT id FROM teams WHERE api_id = 770) AND away_team_id = (SELECT id FROM teams WHERE api_id = 3));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Croatia', 3)), 'Croatia', '🏳️', 3 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 3);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Montenegro', 3)), 'Montenegro', '🏳️', 1109 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1109);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-09-08', (SELECT id FROM teams WHERE api_id = 3), (SELECT id FROM teams WHERE api_id = 1109), 4, 0, 'World Cup - Qualification Europe', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-09-08' AND home_team_id = (SELECT id FROM teams WHERE api_id = 3) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1109));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Nigeria', 3)), 'Nigeria', '🏳️', 19 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 19);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ghana', 3)), 'Ghana', '🏳️', 1504 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1504);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-28', (SELECT id FROM teams WHERE api_id = 19), (SELECT id FROM teams WHERE api_id = 1504), 3, 1, 'African Nations Championship - Qualification', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-28' AND home_team_id = (SELECT id FROM teams WHERE api_id = 19) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1504));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ghana', 3)), 'Ghana', '🏳️', 1504 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1504);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Nigeria', 3)), 'Nigeria', '🏳️', 19 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 19);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-12-22', (SELECT id FROM teams WHERE api_id = 1504), (SELECT id FROM teams WHERE api_id = 19), 0, 0, 'African Nations Championship - Qualification', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-12-22' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1504) AND away_team_id = (SELECT id FROM teams WHERE api_id = 19));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Uganda', 3)), 'Uganda', '🏳️', 1519 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1519);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ghana', 3)), 'Ghana', '🏳️', 1504 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1504);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-03-26', (SELECT id FROM teams WHERE api_id = 1519), (SELECT id FROM teams WHERE api_id = 1504), 2, 2, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-03-26' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1519) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1504));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Nigeria', 3)), 'Nigeria', '🏳️', 19 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 19);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ghana', 3)), 'Ghana', '🏳️', 1504 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1504);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-03-22', (SELECT id FROM teams WHERE api_id = 19), (SELECT id FROM teams WHERE api_id = 1504), 2, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-03-22' AND home_team_id = (SELECT id FROM teams WHERE api_id = 19) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1504));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Ghana', 3)), 'Ghana', '🏳️', 1504 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1504);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Namibia', 3)), 'Namibia', '🏳️', 1493 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 1493);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-01-08', (SELECT id FROM teams WHERE api_id = 1504), (SELECT id FROM teams WHERE api_id = 1493), 0, 0, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-01-08' AND home_team_id = (SELECT id FROM teams WHERE api_id = 1504) AND away_team_id = (SELECT id FROM teams WHERE api_id = 1493));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Mexico', 3)), 'Mexico', '🏳️', 16 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 16);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Panama', 3)), 'Panama', '🏳️', 11 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 11);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-03-24', (SELECT id FROM teams WHERE api_id = 16), (SELECT id FROM teams WHERE api_id = 11), 2, 1, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-03-24' AND home_team_id = (SELECT id FROM teams WHERE api_id = 16) AND away_team_id = (SELECT id FROM teams WHERE api_id = 11));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('USA', 3)), 'USA', '🏳️', 2384 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 2384);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Panama', 3)), 'Panama', '🏳️', 11 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 11);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2025-03-20', (SELECT id FROM teams WHERE api_id = 2384), (SELECT id FROM teams WHERE api_id = 11), 0, 1, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2025-03-20' AND home_team_id = (SELECT id FROM teams WHERE api_id = 2384) AND away_team_id = (SELECT id FROM teams WHERE api_id = 11));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Panama', 3)), 'Panama', '🏳️', 11 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 11);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Costa Rica', 3)), 'Costa Rica', '🏳️', 29 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 29);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-11-19', (SELECT id FROM teams WHERE api_id = 11), (SELECT id FROM teams WHERE api_id = 29), 2, 2, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-11-19' AND home_team_id = (SELECT id FROM teams WHERE api_id = 11) AND away_team_id = (SELECT id FROM teams WHERE api_id = 29));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Costa Rica', 3)), 'Costa Rica', '🏳️', 29 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 29);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Panama', 3)), 'Panama', '🏳️', 11 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 11);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-11-15', (SELECT id FROM teams WHERE api_id = 29), (SELECT id FROM teams WHERE api_id = 11), 0, 1, 'CONCACAF Nations League', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-11-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 29) AND away_team_id = (SELECT id FROM teams WHERE api_id = 11));

INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Canada', 3)), 'Canada', '🏳️', 5529 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 5529);
INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('Panama', 3)), 'Panama', '🏳️', 11 WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = 11);
INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) 
SELECT gen_random_uuid(), '2024-10-15', (SELECT id FROM teams WHERE api_id = 5529), (SELECT id FROM teams WHERE api_id = 11), 2, 1, 'Friendlies', 'EXTERNAL', CURRENT_TIMESTAMP 
WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '2024-10-15' AND home_team_id = (SELECT id FROM teams WHERE api_id = 5529) AND away_team_id = (SELECT id FROM teams WHERE api_id = 11));

