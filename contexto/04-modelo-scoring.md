# 04 — Modelo de Scoring

Implementado en `scoring/ScoringService.java` y `scoring/ScoreExplanationBuilder.java`.

## Fórmula

```
final_score =
    form_weight              * form_score
  + goal_diff_weight         * goal_diff_score
  + opponent_strength_weight * opponent_strength_score
  + previous_world_cup_weight* previous_world_cup_score
  + elo_weight               * elo_score
```

Pesos por defecto: 0.40 / 0.20 / 0.15 / 0.15 / 0.10 (configurables).
Todos los componentes se normalizan a **0–100** antes de ponderar.

### Componentes

**1. Forma (últimos 5 partidos)**
```
puntos = 3*victorias + 1*empates
form_score = puntos / 15 * 100
```

**2. Diferencia de goles (últimos 5)**
```
goal_diff = goles_favor - goles_contra
goal_diff_score = normalizar(goal_diff, min=-10, max=10) -> 0..100
  = clamp((goal_diff - (-10)) / (10 - (-10)) * 100, 0, 100)
```

**3. Fuerza de rivales (promedio últimos 5 rivales)**
Cada rival aporta según su ranking FIFA:
```
Top 5  -> 100
Top 10 -> 90
Top 20 -> 75
Top 50 -> 55
Resto  -> 35
opponent_strength_score = promedio de los rivales enfrentados
```

**4. Desempeño Mundial anterior (2022)** — bonus mapeado a 0–100:
```
CHAMPION        +15 -> 100
RUNNER_UP       +12 -> 90
SEMIFINAL       +8  -> 73
QUARTERFINAL    +4  -> 57
ROUND_OF_16     +2  -> 48
GROUP_STAGE      0  -> 40
DID_NOT_QUALIFY -3  -> 28
```
(El bonus crudo −3..+15 se reescala linealmente a 0..100 para mantener todos
los componentes en la misma escala; el peso del 15% evita que domine.)

**5. ELO / ranking histórico** — normalizado:
```
elo_score = clamp((elo - 1300) / (2100 - 1300) * 100, 0, 100)
```

### Ajuste por amistosos
Los partidos `FRIENDLY` cuentan con factor 0.5 en los puntos de forma para no
inflar el score con amistosos (regla del enunciado).

## Probabilidad de ganar el Mundial

Se usa **softmax con temperatura** sobre el `final_score` de los 48 equipos:
```
peso_i = exp(final_score_i / T)        (T = 12, temperatura)
prob_i = peso_i / sum(peso_j)  * 100
```
Suma 100% sobre las 48 selecciones. T controla cuán "plano" es el reparto.

## Fuente de datos y Persistencia
El modelo es **Offline-First**. No realiza consultas a APIs externas durante el cálculo.
1. Los partidos recientes se importan una única vez y se persisten en la tabla `match_results`.
2. El `ScoringService` consulta exclusivamente la base de datos local.
3. Esto garantiza la velocidad de respuesta, consistencia en los resultados y ahorro de tokens/créditos de API.
