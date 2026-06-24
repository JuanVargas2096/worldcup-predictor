-- Agregar columna api_id a la tabla teams para mapeo con API-Football
ALTER TABLE teams ADD COLUMN api_id INT;

-- Mapeo inicial de IDs para algunas selecciones (basado en IDs típicos de API-Football)
-- Nota: Estos IDs son ilustrativos, el usuario puede necesitar ajustarlos según la suscripción
UPDATE teams SET api_id = 16 WHERE code = 'MEX';
UPDATE teams SET api_id = 983 WHERE code = 'KOR';
UPDATE teams SET api_id = 13 WHERE code = 'CAN';
UPDATE teams SET api_id = 15 WHERE code = 'SUI';
UPDATE teams SET api_id = 6 WHERE code = 'BRA';
UPDATE teams SET api_id = 31 WHERE code = 'MAR';
UPDATE teams SET api_id = 956 WHERE code = 'USA';
UPDATE teams SET api_id = 25 WHERE code = 'GER';
UPDATE teams SET api_id = 10 WHERE code = 'NED';
UPDATE teams SET api_id = 21 WHERE code = 'BEL';
UPDATE teams SET api_id = 9 WHERE code = 'ESP';
UPDATE teams SET api_id = 2 WHERE code = 'FRA';
UPDATE teams SET api_id = 26 WHERE code = 'ARG';
UPDATE teams SET api_id = 27 WHERE code = 'POR';
UPDATE teams SET api_id = 14 WHERE code = 'ENG';
