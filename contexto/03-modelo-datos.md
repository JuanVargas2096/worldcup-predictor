# 03 — Modelo de Datos

Migraciones Flyway en `backend/src/main/resources/db/migration/`.

## Tablas

### `teams`
Selección nacional. Incluye datos del Mundial 2026 (grupo, pot) y fuerza histórica.

| Columna | Tipo | Notas |
|---|---|---|
| id | UUID PK | |
| code | VARCHAR(3) UNIQUE | Código FIFA (ARG, BRA…) |
| name | VARCHAR(100) | |
| confederation | VARCHAR(20) | UEFA, CONMEBOL, AFC, CAF, CONCACAF, OFC |
| fifa_ranking | INT | Posición ranking FIFA (aprox.) |
| elo_rating | NUMERIC(10,2) | Fuerza histórica ELO |
| previous_world_cup_result | VARCHAR(30) | Enum: CHAMPION, RUNNER_UP, SEMIFINAL, QUARTERFINAL, ROUND_OF_16, GROUP_STAGE, DID_NOT_QUALIFY |
| group_letter | VARCHAR(1) | A–L (grupo del Mundial 2026) |
| pot | INT | Bombo del sorteo (1–4; 4 = repechaje) |
| flag_emoji | VARCHAR(10) | Emoji de bandera |
| api_id | INT | ID oficial de API-Football |
| is_eliminated | BOOLEAN | true si el equipo quedó fuera del mundial |
| created_at / updated_at | TIMESTAMP | |

### `matches`
Resultados históricos recientes (alimentan el scoring). **Siempre con marcador.**

| Columna | Tipo | Notas |
|---|---|---|
| id | UUID PK | |
| match_date | DATE | |
| home_team_id / away_team_id | UUID FK teams | |
| home_score / away_score | INT NOT NULL | |
| competition | VARCHAR(100) | |
| match_type | VARCHAR(30) | FRIENDLY, QUALIFIER, NATIONS_LEAGUE, CONTINENTAL… |
| created_at | TIMESTAMP | |

### `fixtures`
Calendario de la fase de grupos del Mundial 2026. Marcador **nullable**.

| Columna | Tipo | Notas |
|---|---|---|
| id | UUID PK | |
| group_letter | VARCHAR(1) | A–L |
| matchday | INT | 1–3 |
| scheduled_date | DATE | Fecha aproximada (jun 2026) |
| venue | VARCHAR(100) | Sede (aprox.) |
| home_team_id / away_team_id | UUID FK teams | |
| home_score / away_score | INT NULL | Null = aún no jugado |
| created_at | TIMESTAMP | |

### `team_scores`
Snapshot del cálculo de cada equipo (historial → gráfico de evolución).

| Columna | Tipo |
|---|---|
| id | UUID PK |
| team_id | UUID FK teams |
| calculated_at | TIMESTAMP |
| form_score / goal_diff_score / opponent_strength_score / previous_world_cup_score / elo_score | NUMERIC(10,2) |
| final_score | NUMERIC(10,2) |
| win_probability | NUMERIC(6,3) | % estimado de ganar el Mundial |
| explanation | TEXT |

### `scoring_config`
Pesos configurables del modelo (solo una fila `active = true`).

| Columna | Tipo | Default |
|---|---|---|
| id | UUID PK | |
| form_weight | NUMERIC(5,2) | 0.40 |
| goal_diff_weight | NUMERIC(5,2) | 0.20 |
| opponent_strength_weight | NUMERIC(5,2) | 0.15 |
| previous_world_cup_weight | NUMERIC(5,2) | 0.15 |
| elo_weight | NUMERIC(5,2) | 0.10 |
| active | BOOLEAN | true |
| created_at | TIMESTAMP | |

### `app_parameter` (Configuración de Sincronización)
Parámetros dinámicos para el comportamiento del sistema.

| Columna | Tipo | Notas |
|---|---|---|
| id | UUID PK | |
| parameter_key | VARCHAR UNIQUE | WORLD_CUP_SYNC_RUNS_PER_DAY, etc. |
| parameter_value | VARCHAR | |
| description | TEXT | |
| active | BOOLEAN | |
| created_at / updated_at | TIMESTAMP | |

### `world_cup_team`
Equipos participantes en el Mundial 2026 (según la API externa).

| Columna | Tipo | Notas |
|---|---|---|
| id | UUID PK | |
| api_team_id | INT UNIQUE | |
| name | VARCHAR | |
| logo_url | VARCHAR | |
| country | VARCHAR | |
| created_at / updated_at | TIMESTAMP | |

### `world_cup_fixture`
Calendario y resultados reales sincronizados de la Copa Mundial 2026.

| Columna | Tipo | Notas |
|---|---|---|
| id | UUID PK | |
| api_fixture_id | INT UNIQUE | |
| home_team_id / away_team_id | UUID FK world_cup_team | |
| goals_home / goals_away | INT | |
| status_short | VARCHAR | FT, TBD, LIVE, etc. |
| fixture_date | TIMESTAMP | |
| venue_name | VARCHAR | |
| raw_response | TEXT/JSON | Respuesta original para auditoría |
| created_at / updated_at | TIMESTAMP | |

### `world_cup_prediction`
Predicción por partido (endpoint `/predictions` de API-Football), persistida DB-first.

| Columna | Tipo | Notas |
|---|---|---|
| id | UUID PK | |
| api_fixture_id | INT UNIQUE | Correlación con `world_cup_fixture.api_fixture_id` |
| percent_home / percent_draw / percent_away | INT | % crudos de la API |
| win_home / win_away | NUMERIC(6,3) | **Prob. de avanzar**: el % de empate se redistribuye proporcionalmente (en knockout no hay empate) |
| advice | TEXT | Consejo textual de la API |
| winner_name / winner_comment | VARCHAR/TEXT | Favorito sugerido |
| raw_response | TEXT/JSON | Respuesta original para auditoría |
| created_at / updated_at | TIMESTAMP | |

## Relaciones
- `matches` y `fixtures` referencian `teams` (home/away).
- `team_scores` referencia `teams` (1 equipo → N snapshots).
- `scoring_config` independiente; la fila activa rige el cálculo.
- `world_cup_fixture` referencia `world_cup_team`.
- `world_cup_prediction` se correlaciona con `world_cup_fixture` por `api_fixture_id`.
