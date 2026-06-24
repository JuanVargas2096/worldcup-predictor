# 09 — Progreso y Pendientes (BITÁCORA)

> **Empieza por aquí si retomas el proyecto.** Última actualización: 2026-06-23.

## Estado general
MVP en construcción. Datos reales de equipos/grupos cargados. Backend y frontend
escritos para levantarse con `docker compose up --build`.

## Hecho
- [x] Investigación de datos reales (48 equipos, grupos A–L) — ver doc 07.
- [x] Carpeta `contexto/` con documentación (docs 00–09).
- [x] Estructura de carpetas backend (Quarkus) y frontend (Angular).
- [x] Esquema Flyway (V1) + seeds: teams (V2), scoring_config (V3).
- [x] Entidades Panache: Team, MatchResult, Fixture, TeamScore, ScoringConfig.
- [x] DTOs + Resources REST (teams, matches, fixtures, rankings, scoring-config).
- [x] ScoringService + ScoreExplanationBuilder + probabilidad softmax.
- [x] FootballDataProvider + MockFootballDataProvider (genera forma reciente).
- [x] ExternalApiFootballDataProvider implementado y funcional con API-Football (Corregido error 404, mapeo por api_id y deduplicación).
- [x] Mapeo completo de IDs oficiales para las 48 selecciones del Mundial 2026.
- [x] Sistema de configuración dinámica y control de cuota (rate-limiting) para la API.
- [x] Bootstrap: genera fixtures round-robin por grupo + partidos recientes + recalcula.
- [x] Frontend Angular SPA: páginas Ranking, Detalle, Fixture, Configuración.
- [x] Dockerfiles + docker-compose.yml + README.

## Pendiente / Próximos pasos (TODO)
- [x] Verificar build real: actualizado a Java 21 y Angular 19.
- [x] Cargar fechas/sedes/oficiales reales del calendario (hoy aproximadas).
- [x] Implementar `ExternalApiFootballDataProvider` contra una API real
      (API-Football / Sportmonks / football-data.org) para forma reciente real.
- [x] Tests (unit del ScoringService; e2e mínimos).
- [x] Scheduler diario (RankingScheduler) — implementado.
- [ ] Persistir fixtures con resultados reales según avanza el torneo.

## Riesgos conocidos
- Java local es 21 (actualizado); el build se recomienda dentro de Docker.
- Forma reciente es **sintética** (MockFootballDataProvider). Equipos/grupos reales.
- Probabilidad por softmax es una aproximación, no una simulación del bracket.

## Cómo continuar
1. Lee este archivo y `02-decisiones-tecnicas.md`.
2. `cd worldcup-predictor && docker compose up --build`.
3. Frontend en http://localhost:4200 — API en http://localhost:8080.
4. Si hay errores, consulta la carpeta `contexto/`.
5. Actualiza esta bitácora con cada cambio relevante.
