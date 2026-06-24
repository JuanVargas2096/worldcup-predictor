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
| group_letter | CHAR(1) | A–L (grupo del Mundial 2026) |
| pot | INT | Bombo del sorteo (1–4; 4 = repechaje) |
| flag_emoji | VARCHAR(10) | Emoji de bandera |
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
| group_letter | CHAR(1) | A–L |
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

## Relaciones
- `matches` y `fixtures` referencian `teams` (home/away).
- `team_scores` referencia `teams` (1 equipo → N snapshots).
- `scoring_config` independiente; la fila activa rige el cálculo.
