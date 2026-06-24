-- Actualizar todos los api_id con los valores correctos de API-Football v3
-- Se han verificado manualmente para las 48 selecciones del Mundial 2026.

-- Grupo A
UPDATE teams SET api_id = 16 WHERE code = 'MEX';
UPDATE teams SET api_id = 17 WHERE code = 'KOR';
UPDATE teams SET api_id = 770 WHERE code = 'CZE';
UPDATE teams SET api_id = 1531 WHERE code = 'RSA';

-- Grupo B
UPDATE teams SET api_id = 5529 WHERE code = 'CAN';
UPDATE teams SET api_id = 15 WHERE code = 'SUI';
UPDATE teams SET api_id = 1569 WHERE code = 'QAT';
UPDATE teams SET api_id = 1113 WHERE code = 'BIH';

-- Grupo C
UPDATE teams SET api_id = 6 WHERE code = 'BRA';
UPDATE teams SET api_id = 31 WHERE code = 'MAR';
UPDATE teams SET api_id = 1108 WHERE code = 'SCO';
UPDATE teams SET api_id = 2386 WHERE code = 'HAI';

-- Grupo D
UPDATE teams SET api_id = 2384 WHERE code = 'USA';
UPDATE teams SET api_id = 777 WHERE code = 'TUR';
UPDATE teams SET api_id = 20 WHERE code = 'AUS';
UPDATE teams SET api_id = 2380 WHERE code = 'PAR';

-- Grupo E
UPDATE teams SET api_id = 25 WHERE code = 'GER';
UPDATE teams SET api_id = 2382 WHERE code = 'ECU';
UPDATE teams SET api_id = 1501 WHERE code = 'CIV';
UPDATE teams SET api_id = 5530 WHERE code = 'CUW';

-- Grupo F
UPDATE teams SET api_id = 1118 WHERE code = 'NED';
UPDATE teams SET api_id = 12 WHERE code = 'JPN';
UPDATE teams SET api_id = 5 WHERE code = 'SWE';
UPDATE teams SET api_id = 28 WHERE code = 'TUN';

-- Grupo G
UPDATE teams SET api_id = 1 WHERE code = 'BEL';
UPDATE teams SET api_id = 22 WHERE code = 'IRN';
UPDATE teams SET api_id = 32 WHERE code = 'EGY';
UPDATE teams SET api_id = 4673 WHERE code = 'NZL';

-- Grupo H
UPDATE teams SET api_id = 9 WHERE code = 'ESP';
UPDATE teams SET api_id = 7 WHERE code = 'URU';
UPDATE teams SET api_id = 23 WHERE code = 'KSA';
UPDATE teams SET api_id = 1533 WHERE code = 'CPV';

-- Grupo I
UPDATE teams SET api_id = 2 WHERE code = 'FRA';
UPDATE teams SET api_id = 13 WHERE code = 'SEN';
UPDATE teams SET api_id = 1090 WHERE code = 'NOR';
UPDATE teams SET api_id = 1567 WHERE code = 'IRQ';

-- Grupo J
UPDATE teams SET api_id = 26 WHERE code = 'ARG';
UPDATE teams SET api_id = 775 WHERE code = 'AUT';
UPDATE teams SET api_id = 1532 WHERE code = 'ALG';
UPDATE teams SET api_id = 1548 WHERE code = 'JOR';

-- Grupo K
UPDATE teams SET api_id = 27 WHERE code = 'POR';
UPDATE teams SET api_id = 8 WHERE code = 'COL';
UPDATE teams SET api_id = 1568 WHERE code = 'UZB';
UPDATE teams SET api_id = 1508 WHERE code = 'COD';

-- Grupo L
UPDATE teams SET api_id = 10 WHERE code = 'ENG';
UPDATE teams SET api_id = 3 WHERE code = 'CRO';
UPDATE teams SET api_id = 1504 WHERE code = 'GHA';
UPDATE teams SET api_id = 11 WHERE code = 'PAN';
