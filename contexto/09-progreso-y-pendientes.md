# 09 — Progreso y Pendientes (BITÁCORA)

> **Empieza por aquí si retomas el proyecto.** Última actualización: 2026-06-24.

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
- [x] Gráfico de Evolución del Score funcional con historial persistente y etiquetas de tiempo.
- [x] Soporte para partidos contra equipos externos (no clasificados) para el cálculo de forma.
- [x] Gestión de equipos eliminados (isEliminated flag) con probabilidad de victoria 0%.
- [x] Filosofía "DB-First" para ahorro de tokens de API y procesamiento, con persistencia obligatoria.
- [x] Script de bash para importación offline y generación de semillas SQL.
- [x] Dockerfiles + docker-compose.yml + README.
- [x] Implementación completa de sincronización del Mundial 2026 (fixtures reales).
- [x] Tabla de parámetros dinámicos (`app_parameter`) para control de ejecución del scheduler.
- [x] Optimización de rendimiento: cache de ranking y HQL eficiente para historial.
- [x] Resiliencia en el arranque: el sistema inicia incluso con fallos en APIs externas.

## Sesión 2026-06-24 (verificación de compilación)
- [x] **Backend COMPILA con JDK 21** (`mvn -DskipTests clean package` → BUILD SUCCESS,
      augmentación Quarkus OK). JDK 21 en `/Library/Java/JavaVirtualMachines/zulu-21.jdk`.
      Maven no está instalado: se usó binario portátil en el scratchpad.
- [x] **Frontend COMPILA** (`ng build` OK, Angular 19).
- [x] Fix: `quarkus.flyway.out-of-order=true` (permite aplicar V8 del import_matches.sh
      después de V9/V10 sin que Flyway falle).
- [x] Fix: warnings de config eliminados (`quarkus.log.file.enable`, logging del
      rest-client a claves globales `quarkus.rest-client.logging.*`).
- [x] Fix: bug de arranque — `MatchResult.count()` se ejecutaba sin sesión Hibernate
      en el observer `@Observes StartupEvent`; ahora va en `QuarkusTransaction.requiringNew()`.
- [x] Confirmado: `WorldCupSyncScheduler` sincroniza equipos + fixtures (pendientes y
      jugados) máx. 6/día (`WORLD_CUP_SYNC_RUNS_PER_DAY`), intervalo 24/N h. Cumple el requisito.

## Sesión 2026-06-24 (parte 2 — fixes #2, #3 y cuelgue del detalle)
- [x] **Fix #2 (arranque)**: `DATA_PROVIDER` default ahora `mock` → boot instantáneo
      sin llamadas HTTP. Datos reales del Mundial vía scheduler; forma real vía botón.
- [x] **Fix cuelgue del detalle** (`/api/rankings/{id}`): el endpoint ya era DB-only, pero:
      - `RankingService` usaba cache `synchronized` que serializaba TODAS las peticiones
        → reemplazado por cache no bloqueante (volatile + TTL 60s).
      - El sync y el import externo mantenían **conexiones de BD abiertas durante el HTTP**
        → ahora el HTTP va FUERA de transacción y la persistencia en transacciones cortas
        (`QuarkusTransaction.requiringNew()`), en `WorldCupSyncService` y `WorldCupSyncScheduler`.
      Resultado: el detalle responde rápido y nunca queda bloqueado por el pool.
- [x] **Fix #3 (fixtures reales en SPA)**: nuevo `WorldCupFixtureDto` (evita
      LazyInitializationException), `WorldCupResource.getFixtures` mapea a DTO en tx y
      ordena por fecha. Nueva página Angular **/mundial** (`live.component.ts`) que muestra
      partidos reales por ronda, con marcador/estado/logos y botón "Sincronizar ahora".
- [x] Verificado: backend `BUILD SUCCESS` (47 fuentes) y `ng build` OK con la nueva página.

### Fix runtime (2026-06-24): error "did you forget to annotate your entity with @Entity?"
- Causa: `QuarkusTransaction.requiringNew().call(MatchResult::count)` en DataInitializer.
  Panache reescribe las llamadas `invokestatic` pero NO las *method references* → caía en
  el método base de PanacheEntityBase. Solución: lambda `() -> MatchResult.count()`.
- Regla general: nunca uses `Entidad::metodoEstaticoPanache` (count/list/find/persist…);
  usa siempre un lambda o la llamada directa.

### Sesión 2026-06-24 (parte 3 — datos por scheduler, no on-demand)
- [x] Detalle/ranking ahora `@Transactional` (GET): una sola sesión/conexión para
      todas las lecturas → evita errores de sesión y churn de conexiones.
- [x] NUEVO `MatchImportScheduler`: importa forma reciente REAL desde la API y la
      PERSISTE en BD (1ª corrida ~2 min tras boot, luego cada 6 h). En segundo plano,
      no bloquea el arranque ni la ruta de peticiones. Si no hay key, no hace nada.
- [x] `ExternalApiFootballDataProvider` refactorizado: HTTP FUERA de transacción +
      persistencia en transacciones cortas (`QuarkusTransaction`). Guard cuenta solo
      partidos reales (matchType='EXTERNAL'); al importar real borra los 'MOCK' del equipo.
- [x] `MockFootballDataProvider` marca sus partidos como matchType='MOCK' (reemplazables).
- [x] Botón "Importar" (`/api/matches/import`) ahora usa el provider EXTERNAL (real),
      no el router (que era mock y hacía deleteAll → borraba lo real).
- Resultado: las pantallas SIEMPRE leen de BD; los datos los trae y persiste el scheduler.
- Pendiente de confirmar por el usuario: stacktrace exacto del error de detalle si persiste
  tras reconstruir (la ruta de detalle ya es 100% lectura de BD).

### Sesión 2026-06-24 (parte 4 — cuelgue del FRONTEND en detalle)
- Causa real (no era el backend): `team-detail.component.ts` usaba un **setter de
  `@ViewChild('chart')`** que llamaba `renderChart()`. Angular lo invoca en cada ciclo
  de CD y, al crear Chart.js DENTRO de la zona con animación (requestAnimationFrame),
  se generaba un bucle de detección de cambios → congelaba la pestaña.
- Fix: ViewChild como propiedad simple (sin efectos), `animation:false`, crear el
  gráfico con `ngZone.runOutsideAngular`, render una sola vez (guard), y `breakdown`
  precalculado a un campo (no método en el template).
- Regla general Angular: no pongas lógica/efectos en setters de @ViewChild ni crees
  charts dentro de la zona; usa runOutsideAngular y evita métodos en *ngFor del template.

### Sesión 2026-06-24 (parte 5 — gráfico en blanco + datos al día con Mundial)
- Gráfico "Evolución del score" en blanco: el canvas se creaba antes del layout del
  contenedor (250px) → Chart.js dibujaba con tamaño 0. Fix: crear dentro de
  `requestAnimationFrame` (y fuera de la zona Angular).
- Datos desactualizados (mostraba Copa América 2024): el import usaba `season=2024` fijo.
  Ahora `ExternalApiFootballDataProvider` usa el parámetro `last` de API-Football, que
  trae los partidos más recientes de CUALQUIER competición (incluido el Mundial 2026).
- Refresco periódico real: el guard pasó de "ya tiene >=5" a "antigüedad" (`STALE_HOURS=12`
  sobre createdAt). Cada importación REEMPLAZA la forma del equipo (borra MOCK+EXTERNAL e
  inserta los últimos jugados). El `MatchImportScheduler` (cada 6h, +2min al boot) mantiene
  la data al día; acotado por la cuota diaria (ConfigurationService, 100/día).
- Botón "Importar partidos" → `refreshRecentMatches(true)` (force): ignora la antigüedad
  y refresca todo de inmediato. Útil tras desplegar para ver ya los datos del Mundial.

### Sesión 2026-06-24 (parte 6 — cron 6h, sin on-demand, y despliegue a registry)
- Import de partidos AHORA por **cron cada 6h** (`MatchImportScheduler`,
  `@Scheduled(cron="0 0 */6 * * ?")`). Eliminado el delay/inicial.
- Quitada de la WEB la opción on-demand: la pantalla de Configuración ya NO tiene la
  sección "Datos y Partidos" / botón "Importar partidos". (`config.component.ts`,
  `api.service.ts` sin `importMatches`). Endpoint `POST /api/matches/import` sigue para curl.
- **API key externalizada**: `application.properties` usa `FOOTBALL_API_KEY` (default NO_KEY).
  Ya NO hay key real en el código. Se pasa por `.env` (gitignored).
- **Despliegue a registry propio** `registry.mrvargas.net`:
  - `docker-compose.yml` reescrito con `image:` (registry) + `build:` + variables `.env`.
  - `.env.example` con todas las variables; `.env` en `.gitignore`.
  - `docker-compose.sh` (up/logs/down/reset) — crea `.env` y levanta todo. BD contenerizada.
  - `.github/workflows/build-and-push.yml`: CI que construye y publica backend+frontend.
    Requiere secrets `REGISTRY_USERNAME` / `REGISTRY_PASSWORD` en GitHub.
  - Frontend ya genera imagen nginx (multi-stage). Ver `contexto/10-despliegue.md`.
- Primer arranque con BD vacía: Flyway (V1..V10) + DataInitializer siembran todo; sin pasos manuales.

### Sesión 2026-06-24 (parte 7 — deploy nginx-proxy/ranger, root-path, hash)
- Backend con contexto extra: `quarkus.http.root-path=/worldcup-service` (todo cuelga de ahí).
- Frontend con **hash routing** (`provideRouter(routes, withHashLocation())`) → URLs `/#/...`.
- `ApiService.base = /worldcup-service/api`; `proxy.conf.json` (dev) proxea `/worldcup-service`.
- `frontend/nginx.conf` reescrito: sirve SPA + reverse-proxy `/worldcup-service/` →
  `worldcup-backend:8080` (resolver runtime) + `/healthz`.
- NUEVO `deploy/docker-compose.yml` (convención internas/deploy): red `ranger` (external),
  `VIRTUAL_HOST/VIRTUAL_PORT/LETSENCRYPT_HOST/LETSENCRYPT_EMAIL` en el frontend, imágenes del
  registry, `pull_policy: always`, sin publicar puertos. `PUBLIC_HOST=worldcup-predictions.mrvargas.net`.
- `.env.example` con `PUBLIC_HOST` y `LETSENCRYPT_EMAIL`. Raíz `docker-compose.yml` queda para local.

### Notas / pendientes derivados
- La forma reciente del predictor (`matches`) sigue siendo mock salvo que se pulse
  "Importar partidos" o se ponga `DATA_PROVIDER=external`. El `ExternalApiFootballDataProvider`
  aún hace su import en una sola transacción (acción on-demand del botón, no en el boot).
- API key real sigue commiteada en `application.properties` (ver abajo).

### Decisiones abiertas (requieren al usuario)
- ~~API key real commiteada~~ → RESUELTO: externalizada a `FOOTBALL_API_KEY` (default NO_KEY),
  se pasa por `.env`. Recordar configurar la key en `.env` del servidor para datos reales.
- **Estrategia de datos al boot**: hoy `DATA_PROVIDER=external` → en BD fresca hace ~48
  llamadas a la API una vez (datos persisten en el volumen). Alternativa: mock al boot.
- **Fixtures reales en el SPA**: `/api/world-cup/fixtures` (datos sincronizados) aún NO
  se muestran en Angular; la vista Fixture usa los grupos sembrados (`/api/groups`).

## Pendiente / Próximos pasos (TODO)
- [x] Verificar build real: actualizado a Java 21 y Angular 19.
- [x] Cargar fechas/sedes/oficiales reales del calendario (hoy aproximadas).
- [x] Implementar `ExternalApiFootballDataProvider` contra una API real
      (API-Football / Sportmonks / football-data.org) para forma reciente real.
- [x] Tests (unit del ScoringService; e2e mínimos).
- [x] Scheduler diario (RankingScheduler) — implementado.
- [x] Persistir fixtures con resultados reales según avanza el torneo (Sincronización v3).
- [ ] Pruebas unitarias de los nuevos servicios de sincronización.
- [ ] Dashboard de administración para parámetros de configuración.

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
