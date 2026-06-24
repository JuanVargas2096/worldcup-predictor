-- 48 selecciones clasificadas al Mundial 2026 (datos reales del sorteo del 05-dic-2025).
-- Pot 1 = cabeza de serie del grupo; pots 2-4 ordenados por fuerza ELO.
-- previous_world_cup_result: desempeño en Qatar 2022.

INSERT INTO teams (code, name, confederation, fifa_ranking, elo_rating, previous_world_cup_result, group_letter, pot, flag_emoji) VALUES
-- Grupo A
('MEX','México','CONCACAF',17,1800,'GROUP_STAGE','A',1,'🇲🇽'),
('KOR','Corea del Sur','AFC',23,1740,'ROUND_OF_16','A',2,'🇰🇷'),
('CZE','Chequia','UEFA',40,1680,'DID_NOT_QUALIFY','A',3,'🇨🇿'),
('RSA','Sudáfrica','CAF',56,1620,'DID_NOT_QUALIFY','A',4,'🇿🇦'),
-- Grupo B
('CAN','Canadá','CONCACAF',30,1700,'GROUP_STAGE','B',1,'🇨🇦'),
('SUI','Suiza','UEFA',19,1790,'ROUND_OF_16','B',2,'🇨🇭'),
('QAT','Qatar','AFC',52,1560,'GROUP_STAGE','B',3,'🇶🇦'),
('BIH','Bosnia y Herzegovina','UEFA',74,1550,'DID_NOT_QUALIFY','B',4,'🇧🇦'),
-- Grupo C
('BRA','Brasil','CONMEBOL',5,2010,'QUARTERFINAL','C',1,'🇧🇷'),
('MAR','Marruecos','CAF',12,1850,'SEMIFINAL','C',2,'🇲🇦'),
('SCO','Escocia','UEFA',39,1680,'DID_NOT_QUALIFY','C',3,'🏴󠁧󠁢󠁳󠁣󠁴󠁿'),
('HAI','Haití','CONCACAF',83,1480,'DID_NOT_QUALIFY','C',4,'🇭🇹'),
-- Grupo D
('USA','Estados Unidos','CONCACAF',16,1790,'ROUND_OF_16','D',1,'🇺🇸'),
('TUR','Turquía','UEFA',27,1740,'DID_NOT_QUALIFY','D',2,'🇹🇷'),
('AUS','Australia','AFC',26,1720,'ROUND_OF_16','D',3,'🇦🇺'),
('PAR','Paraguay','CONMEBOL',45,1650,'DID_NOT_QUALIFY','D',4,'🇵🇾'),
-- Grupo E
('GER','Alemania','UEFA',10,1900,'GROUP_STAGE','E',1,'🇩🇪'),
('ECU','Ecuador','CONMEBOL',24,1730,'GROUP_STAGE','E',2,'🇪🇨'),
('CIV','Costa de Marfil','CAF',42,1670,'DID_NOT_QUALIFY','E',3,'🇨🇮'),
('CUW','Curazao','CONCACAF',90,1450,'DID_NOT_QUALIFY','E',4,'🇨🇼'),
-- Grupo F
('NED','Países Bajos','UEFA',7,1940,'QUARTERFINAL','F',1,'🇳🇱'),
('JPN','Japón','AFC',18,1790,'ROUND_OF_16','F',2,'🇯🇵'),
('SWE','Suecia','UEFA',35,1700,'DID_NOT_QUALIFY','F',3,'🇸🇪'),
('TUN','Túnez','CAF',49,1620,'GROUP_STAGE','F',4,'🇹🇳'),
-- Grupo G
('BEL','Bélgica','UEFA',8,1910,'GROUP_STAGE','G',1,'🇧🇪'),
('IRN','Irán','AFC',21,1750,'GROUP_STAGE','G',2,'🇮🇷'),
('EGY','Egipto','CAF',33,1700,'DID_NOT_QUALIFY','G',3,'🇪🇬'),
('NZL','Nueva Zelanda','OFC',86,1480,'DID_NOT_QUALIFY','G',4,'🇳🇿'),
-- Grupo H
('ESP','España','UEFA',3,2050,'ROUND_OF_16','H',1,'🇪🇸'),
('URU','Uruguay','CONMEBOL',15,1820,'GROUP_STAGE','H',2,'🇺🇾'),
('KSA','Arabia Saudita','AFC',58,1580,'GROUP_STAGE','H',3,'🇸🇦'),
('CPV','Cabo Verde','CAF',70,1530,'DID_NOT_QUALIFY','H',4,'🇨🇻'),
-- Grupo I
('FRA','Francia','UEFA',2,2050,'RUNNER_UP','I',1,'🇫🇷'),
('SEN','Senegal','CAF',20,1760,'ROUND_OF_16','I',2,'🇸🇳'),
('NOR','Noruega','UEFA',28,1730,'DID_NOT_QUALIFY','I',3,'🇳🇴'),
('IRQ','Irak','AFC',57,1560,'DID_NOT_QUALIFY','I',4,'🇮🇶'),
-- Grupo J
('ARG','Argentina','CONMEBOL',1,2100,'CHAMPION','J',1,'🇦🇷'),
('AUT','Austria','UEFA',25,1740,'DID_NOT_QUALIFY','J',2,'🇦🇹'),
('ALG','Argelia','CAF',38,1690,'DID_NOT_QUALIFY','J',3,'🇩🇿'),
('JOR','Jordania','AFC',64,1540,'DID_NOT_QUALIFY','J',4,'🇯🇴'),
-- Grupo K
('POR','Portugal','UEFA',6,1980,'QUARTERFINAL','K',1,'🇵🇹'),
('COL','Colombia','CONMEBOL',14,1820,'DID_NOT_QUALIFY','K',2,'🇨🇴'),
('UZB','Uzbekistán','AFC',55,1580,'DID_NOT_QUALIFY','K',3,'🇺🇿'),
('COD','RD Congo','CAF',60,1560,'DID_NOT_QUALIFY','K',4,'🇨🇩'),
-- Grupo L
('ENG','Inglaterra','UEFA',4,2000,'QUARTERFINAL','L',1,'🏴󠁧󠁢󠁥󠁮󠁧󠁿'),
('CRO','Croacia','UEFA',11,1860,'SEMIFINAL','L',2,'🇭🇷'),
('GHA','Ghana','CAF',47,1640,'GROUP_STAGE','L',3,'🇬🇭'),
('PAN','Panamá','CONCACAF',41,1620,'DID_NOT_QUALIFY','L',4,'🇵🇦');
