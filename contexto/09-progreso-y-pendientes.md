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

### Sesión 2026-06-24 (parte 8 — responsive mobile + orden descendente en /#/mundial)
- [x] **/#/mundial orden descendente**: `live.component.ts` → `groupByRound()` ahora ordena
      por `fixtureDate` DESC antes de agrupar. Las rondas se muestran con la más reciente
      arriba (el `Map` preserva orden de inserción) y dentro de cada ronda también desc.
      Helper `time()` tolera fechas nulas/inválidas. Hecho en el FRONTEND (no se recompila
      Quarkus): el endpoint sigue devolviendo `asc`, el orden visible lo controla la SPA.
- [x] **Mobile /#/mundial**: la fila de partido pasó de `flex` con `flex-1` (sin truncado →
      nombres largos rompían el layout) a un grid `[1fr_auto_1fr]` con `min-w-0` + `truncate`,
      logos/tipos escalados (`w-5 sm:w-6`, `text-sm sm:text-base`), gaps/paddings reducidos.
- [x] **Mobile ranking**: tabla responsive sin scroll horizontal. Columna **Grupo** oculta
      (`hidden sm:table-cell`) → chip junto al nombre; columna **Últimos 5** oculta
      (`hidden md:table-cell`) → form badges bajo el nombre; barra de score y paddings adaptados.
- [x] **Mobile detalle de equipo**: cabecera apila score bajo el nombre en móvil; tabla de
      "Últimos 5" oculta la columna de competición en pantallas pequeñas y compacta la fecha.
- [x] **Mobile configuración**: títulos/paddings escalados (ya era full-width con `max-w-xl`).
- [x] Verificado: `ng build --configuration production` → bundle generado sin errores.
- Regla general responsive: en filas de "VS" usar grid `[1fr_auto_1fr]` + `min-w-0`/`truncate`
  (no `flex-1` sin truncado); en tablas anchas ocultar columnas secundarias con
  `hidden sm:table-cell`/`md:table-cell` y reubicar esa data bajo la celda principal en móvil.

### Sesión 2026-06-24 (parte 9 — eliminatorias: bracket + predicciones por partido)
- [x] **Predictions API**: nuevo método `ApiFootballClient.getPredictions(key, fixtureId)` (`/predictions`)
      + DTO de parseo `provider/dto/ApiPrediction` (winner, advice, percent home/draw/away).
- [x] **Entidad + migración**: `WorldCupPrediction` (tabla `world_cup_prediction`) + `V11__add_world_cup_predictions.sql`.
      Guarda los percent crudos y `win_home/win_away` = **probabilidad de avanzar** (en knockout no hay
      empate → el % de empate se redistribuye proporcionalmente entre ambos equipos).
- [x] **Bracket estático** `KnockoutBracket`: clasifica el texto de ronda de la API (16avos→Final) y define
      el emparejamiento de hermanos (consecutivo `i XOR 1`) para hallar los "2 posibles rivales" de la
      siguiente fase. La API NO da el enlace partido→partido; se asume orden cronológico = orden del bracket
      (corregible aquí si no calza).
- [x] **Servicio** `WorldCupPredictionService` (DB-first, mismo patrón que el sync):
      - `refreshPredictions(season)`: HTTP FUERA de tx, persistencia en tx cortas, acotado por cuota
        (`ConfigurationService.canMakeApiCall/registerApiCall`). Solo partidos de knockout con ambos equipos
        definidos; refresca si no hay predicción o si está vieja (>12 h) y el partido no terminó.
      - `buildBracket(season)`: 100% lectura de BD; agrupa por ronda, ordena, calcula rivales posibles.
- [x] **Endpoints** (`WorldCupResource`): `GET /api/world-cup/bracket?season=2026` (DB-only) y
      `POST /api/world-cup/predictions/refresh` (acción manual). El `WorldCupSyncScheduler` ahora también
      llama `refreshPredictions(2026)` tras sincronizar (misma cadencia, sin on-demand por petición).
- [x] **Frontend**: modelos `BracketRound/BracketMatchItem`, `ApiService.getWorldCupBracket()`, y sección
      **"Eliminatorias · Predicciones"** arriba de la lista en `/#/mundial` (`live.component`): por partido,
      equipos+logos, marcador/estado, **barras de % de avanzar** (emerald/sky), `advice`, y bloque
      **"Si gana, su rival sería"** con los 2 posibles rivales (o "Por definir"). Responsive (grid
      `[1fr_auto_1fr]`, `truncate`).
- [x] Verificado: backend `BUILD SUCCESS` (JDK 21, Flyway V11 OK) y `ng build` producción OK.
- Sin API key o antes de definirse los cruces: el bracket muestra "Por definir" y "Predicción no disponible",
  sin % ni errores (consistente con el MVP).
- Riesgo a validar con datos reales: correlación orden-API ↔ orden-bracket en `KnockoutBracket`.

### Sesión 2026-06-24 (parte 10 — selector de Mundial 2022/2026 en /#/mundial)
- [x] **Selector de temporada** en `live.component`: segmented control "Mundial 2026 / Mundial 2022".
      `season` (default 2026) + `selectSeason(s)` que recarga fixtures + bracket de esa temporada.
      Título e intro dinámicos; `load/loadBracket/sync` usan `this.season`.
- [x] **Sync por temporada**: el botón "Sincronizar ahora" ahora sincroniza la temporada seleccionada
      (`syncWorldCup(1, this.season)`). El modelo ya era multi-temporada (columna `season` en
      `world_cup_fixture`; endpoints `/fixtures` y `/bracket` aceptan `season`).
- [x] **Backend**: `WorldCupResource.manualSync` ahora también llama `refreshPredictions(s)` tras
      sincronizar (igual que el scheduler) → el botón deja fixtures + predicciones listos en un paso.
- [x] Verificado: `ng build` OK y backend `BUILD SUCCESS`.
- Notas: el Mundial 2022 (32 equipos) arranca el knockout en **Octavos (Round of 16)**, sin 16avos;
  `KnockoutBracket` lo maneja. Las predicciones de /predictions para torneos antiguos (2022) PUEDEN venir
  vacías desde la API; en ese caso el bracket muestra resultados reales + posibles rivales, pero sin barras %.
- Pendiente de despliegue + verificación con datos reales (ver abajo).

### Sesión 2026-06-24 (parte 11 — vista de LLAVE (bracket) de dos lados)
- [x] La sección "Eliminatorias" pasó de lista de cards a una **llave de torneo de dos mitades** que
      convergen al centro (final). `live.component`:
      - `buildBracketColumns()` reparte cada ronda: primera mitad → `leftColumns` (fuera→centro), segunda
        mitad → `rightColumns` (centro→fuera, ronda invertida); `finalMatch` al centro y `thirdPlace` debajo.
        Usa el mismo emparejamiento de hermanos del backend (orden por fecha), ya validado con 2022.
      - Plantilla de celda reutilizable (`<ng-template #cell>` + `ngTemplateOutlet`): 2 filas (local/visitante)
        con bandera, nombre (truncate), **% de avanzar** y marcador; resalta en verde a quien pasó de ronda;
        `title=advice` en hover. Final con borde ámbar + "Campeón: X".
      - Columnas con `justify-around` para el efecto de convergencia; contenedor `overflow-x-auto` →
        scroll horizontal en móvil (con hint "↔ Desliza"). Anchos compactos (140–185px).
- [x] **Backend**: `BracketMatchDto` ahora incluye `homeWinner/awayWinner` (de la API, con desempate por
      penales) para resaltar al que avanzó; `WorldCupPredictionService.toMatchDto` los pasa. Modelo TS
      `BracketMatchItem` actualizado.
- [x] Verificado: `ng build` OK y backend `BUILD SUCCESS`. (Requiere redeploy del backend para los nuevos
      campos `homeWinner/awayWinner`; sin redeploy llegan `null` y solo no se resalta el ganador.)
- Estructura por torneo: 2026 (32 al knockout) → R32,R16,QF,SF,Final; 2022 (16) → Octavos,Cuartos,SF,Final.
  `KnockoutBracket`/`buildBracketColumns` manejan ambos. El 3.er puesto se muestra aparte bajo la final.

### Sesión 2026-06-24 (parte 12 — conectores de la llave)
- [x] Añadidas las **líneas conectoras** entre partidos (codos en "Y") vía `styles` del componente +
      clases `bk-*`. Técnica: cada `.bk-m` es un slot de igual altura (`flex:1 1 0`), así los dos hermanos
      quedan centrados respecto al partido de la ronda interior → alineación exacta. Los codos se dibujan
      con bordes en pseudo-elementos: par exterior `::after` (border-top/bottom + border-right) y entrada
      `::before` (border-top) en la tarjeta interior; mitad derecha en espejo; la final recibe un tramo de
      cada lado (`.bk-final::before/::after`). Separación fija `gap:2rem` = 2× tramo (1rem).
- [x] Columnas con metadata `pairs` (len>1 → dibuja codo) y `leadin` (recibe conector; todas menos la más
      externa de cada mitad). Campeón + 3.er puesto movidos DEBAJO de la llave para no descentrar la final.
- [x] Verificado: `ng build` OK.
- Nota: alineación validada por construcción (slots iguales); si al verla hay un pixel de desfase, se ajusta
  `min-height` de `.bk-m` o el `gap`/ancho del tramo (1rem) en el bloque `styles`.

### Sesión 2026-06-24 (parte 13 — API key desde BD, no por variable de entorno)
- [x] La API key ahora se obtiene de la **BD** (tabla `configuration`, code `FOOTBALL_API_KEY`) como fuente
      de verdad. `ConfigurationService`: `getApiKey()` (BD→env fallback), `setApiKey()`, `getApiKeySource()`
      ("db"/"env"/"none"), `getEnvApiKey()`. La variable de entorno queda SOLO como bootstrap.
- [x] **Bootstrap**: en `DataInitializer.onStart`, si el origen es "env" (BD sin key, env presente) se
      siembra la key en BD una vez. Tras eso se puede retirar la variable de entorno.
- [x] Reemplazados los 3 `@ConfigProperty(name="football.api.key")` (WorldCupSyncService,
      WorldCupPredictionService, ExternalApiFootballDataProvider) por `configurationService.getApiKey()`.
- [x] **Endpoint** `ConfigResource`: `GET /api/config/api-key` (estado: configured/source/masked) y
      `PUT /api/config/api-key` ({value}) para gestionarla sin env.
- [x] **Frontend**: nueva sección en `/#/configuracion` con estado de la key (enmascarada + origen),
      input password y botón "Guardar key" (`getApiKeyStatus`/`setApiKey`).
- [x] Verificado: backend `BUILD SUCCESS` y `ng build` OK.
- Nota: `application.properties` mantiene `football.api.key=${FOOTBALL_API_KEY:NO_KEY}` solo como bootstrap;
  comentario actualizado. La key real nunca se commitea.

### Fix arranque (2026-06-24): V8 fallaba por colisión de teams.code (Belarus 'BEL' = Bélgica)
- Síntoma: `docker compose up` → Flyway aplica V8 (out-of-order) y revienta con
  `duplicate key value violates unique constraint "teams_code_key"` (Belarus→'BEL' choca con Bélgica).
- Causa: `import_matches.sh` inserta equipos RIVALES externos con `code = UPPER(LEFT(nombre,3))` y dedupe
  solo por `api_id`; el código NO es único entre externos y los 48 reales.
- Fix: nueva migración **`V7_9__drop_teams_code_unique.sql`** → `ALTER TABLE teams DROP CONSTRAINT IF EXISTS
  teams_code_key`. Versión fraccionaria a propósito: con `out-of-order=true` se aplica ANTES de V8 (tanto en
  BD existentes con V8 pendiente como en instalaciones nuevas, justo tras V7). NO se tocó V8 (no está en el
  árbol, se genera con la API key).
- Seguro: externos se referencian por `api_id`/`id` (no por código); `Team.findByCode` usa `firstResult()`
  (tolera duplicados); unicidad de los 48 reales se mantiene por datos (V2) y por app (TeamResource).
- **Acción requerida**: reconstruir la imagen del backend (la migración va dentro del jar), no solo reiniciar:
  `docker compose up --build` (o rebuild + up). Verificado: `BUILD SUCCESS`, V7_9 empaquetada en el jar.

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
