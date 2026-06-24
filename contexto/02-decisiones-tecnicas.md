# 02 — Decisiones Técnicas

## Stack final

### Backend
- **Java 21** + **Quarkus 3.17** (LTS-ish, estable).
- **Quarkus REST** (antes RESTEasy Reactive) con Jackson.
- **Hibernate ORM con Panache** (entidades activas, menos boilerplate).
- **PostgreSQL 16** vía `quarkus-jdbc-postgresql`.
- **Flyway** para el esquema y semillas de datos reales.
- **Hibernate Validator** para validaciones de DTOs.
- CORS habilitado para el frontend.

### Frontend
- **Angular 18** (standalone components, sin NgModules) como **SPA**.
- **TailwindCSS 3** para estilos.
- **ng2-charts / Chart.js** para el gráfico de evolución (ligero y estable).
- `HttpClient` + servicios para consumir la API (sin Axios; es Angular).
- Servido en producción por **nginx** (build estático).

### Infraestructura
- **Docker Compose**: `db` (Postgres) + `backend` (Quarkus JVM) + `frontend` (nginx).
- Build multi-stage en los Dockerfile (no se necesita Maven/JDK21/ng local).

## Decisiones y justificación

1. **Java 21 en Docker, no local.** La máquina de desarrollo tiene Java 11; por
   eso TODO el build ocurre dentro de contenedores multi-stage. `docker compose
   up --build` es el único comando necesario.
2. **Panache sobre JOOQ/JDBC.** Menos código para un MVP; el dominio es simple.
3. **Tabla `fixtures` separada de `matches`.** `matches` son resultados
   históricos (con marcador, alimentan el scoring). `fixtures` es el calendario
   del Mundial (puede no tener marcador todavía). Mantenerlos separados evita
   nulos en `matches` y mantiene clara la semántica.
4. **Datos de forma reciente sintéticos pero realistas.** Generar 5+ partidos
   reales por las 48 selecciones requeriría una fuente en vivo. El MVP usa
   `MockFootballDataProvider` que genera partidos recientes deterministas según
   la fuerza (ELO) de cada equipo. **Los grupos y equipos SÍ son reales.** El
   `ExternalApiFootballDataProvider` queda como punto de extensión para datos
   reales (API-Football, Sportmonks, football-data.org).
5. **Probabilidad = softmax sobre el score final.** Convierte los puntajes 0–100
   en una distribución que suma 100% sobre los 48 equipos (ver doc 04).
6. **Angular standalone + signals/servicios simples.** Menos ceremonia que
   NgModules; alineado con Angular moderno.

## Versiones fijadas (para reproducibilidad)
- Quarkus BOM: `3.17.5`
- PostgreSQL: `16`
- Node base imagen frontend: `node:22-alpine`
- Maven imagen backend: `maven:3.9-eclipse-temurin-21`
- nginx: `nginx:1.27-alpine`
