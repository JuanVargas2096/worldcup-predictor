# 01 — Objetivo y Alcance

## Objetivo

Construir una WebApp que estime **qué selección tiene más probabilidad de ganar
la Copa del Mundo 2026** y que muestre el **fixture de la fase de grupos** a
partir de los 48 equipos clasificados.

## Funcionalidades del MVP

1. **Ranking de favoritos**: lista de selecciones ordenadas por un puntaje 0–100,
   con probabilidad estimada de ganar el torneo, últimos 5 resultados y desglose.
2. **Detalle de selección**: últimos 5 partidos, goles a favor/contra, diferencia
   de goles, fuerza promedio de rivales, desempeño en Mundial anterior (2022),
   explicación textual del puntaje y gráfico de evolución del score.
3. **Fixture fase de grupos**: los 12 grupos (A–L) con sus 4 equipos reales y el
   calendario round-robin (3 jornadas, 6 partidos por grupo).
4. **Configuración del modelo**: editar los pesos del scoring (deben sumar 100%).

## Restricciones funcionales clave (del enunciado)

- No considerar partidos sin resultado en el scoring.
- Últimos 5 partidos ordenados por fecha descendente.
- Menor peso a amistosos (`match_type`).
- Evitar que 5 victorias ante rivales débiles posicionen artificialmente primero
  (de ahí el componente "fuerza de rivales").
- El Mundial anterior influye pero no decide solo.
- Guardar explicación textual del cálculo (transparencia).

## Fuera de alcance del MVP (ver mejoras futuras)

- Integración real con API-Football / Sportmonks (queda el provider preparado).
- Simulación Monte Carlo del bracket completo.
- Login / panel admin con autenticación.
- Predicción partido por partido de la fase eliminatoria.

## Diferencias respecto al spec original

- **Frontend en Angular** (no React) como Single Page Application.
- Se añade la vista **Fixture** de fase de grupos (requisito explícito).
- Se añade tabla `fixtures` y campos de grupo/pot en `teams`.
