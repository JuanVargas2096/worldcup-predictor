# 05 — Estructura del Backend (Quarkus)

Raíz: `backend/`. Java 21, Quarkus 3.17, Panache, Flyway.

## Paquetes (`src/main/java/com/worldcup/`)

```
team/        Team (entidad), TeamDto, TeamRequest, TeamResource
match/       MatchResult (entidad, tabla matches), MatchDto, MatchRequest, MatchResource
fixture/     Fixture (entidad), FixtureDto, GroupDto, FixtureResource, FixtureGenerator
scoring/     TeamScore, ScoringConfig (entidades),
             ScoringService (algoritmo + softmax),
             ScoreExplanationBuilder, RankingService,
             RankingResource, ScoringConfigResource,
             DTOs: RankingEntryDto, TeamDetailDto, MatchSummaryDto,
                   ScoreHistoryPointDto, ScoringConfigDto,
             WorldCupResultWeights, FormStats
provider/    FootballDataProvider (interfaz),
             MockFootballDataProvider, ExternalApiFootballDataProvider,
             FootballDataProviderRouter (bean inyectable que delega)
bootstrap/   DataInitializer (StartupEvent), RankingScheduler (@Scheduled diario)
common/      ApiExceptionMapper (errores JSON)
```

## Notas de diseño
- **Entidades Panache** con campos públicos y métodos estáticos de consulta.
- **DTOs como records** para request/response; nunca se exponen entidades crudas.
- **Provider inyectable**: `FootballDataProviderRouter` es el único bean que
  expone el tipo `FootballDataProvider` (las impls usan `@Typed(...)` para no
  colisionar). Selecciona mock/external según `worldcup.data-provider`.
- **Cálculo**: `ScoringService.recalculateAll()` recorre los equipos, calcula los
  5 componentes, el score final ponderado y la probabilidad (softmax), guarda un
  `TeamScore` por equipo (historial → gráfico).
- **Arranque** (`DataInitializer`): genera fixtures (si vacío), importa forma
  reciente (si vacío) y recalcula el ranking. Idempotente.

## Endpoints (resumen)
Ver README. Base `/api`. CORS abierto (config en `application.properties`).

## Configuración relevante (`application.properties`)
- Datasource por variables `DB_URL/DB_USERNAME/DB_PASSWORD`.
- `quarkus.hibernate-orm.schema-management.strategy=none` (Flyway manda).
- `worldcup.data-provider=mock|external`.
- `worldcup.recalculate-on-start=true`.

## Build
Multi-stage Docker (`backend/Dockerfile`): Maven+JDK21 compila, JRE21 ejecuta.
No requiere Maven/JDK local.
