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
4. **Persistencia y ahorro de tokens.** El sistema prioriza el uso de la base de datos local para todos los cálculos. Los datos de partidos recientes se obtienen una única vez vía `ExternalApiFootballDataProvider` y se cargan en la BD. Esto evita llamadas redundantes a APIs externas, ahorrando créditos de API y tokens de procesamiento en cada reinicio o recálculo de ranking.
5. **Probabilidad = softmax sobre el score final.** Convierte los puntajes 0–100 en una distribución que suma 100% sobre los 48 equipos (ver doc 04).
6. **Angular standalone + signals/servicios simples.** Menos ceremonia que NgModules; alineado con Angular moderno.

## Estrategia de gestión de tokens (API Credits)
Para maximizar el uso de la capa gratuita de API-Football (100 peticiones/día), se han tomado las siguientes medidas:
- **Offline-First:** El `ScoringService` nunca llama a la API externa; solo consume `MatchResult` de la BD.
- **Importación Inteligente:** `ExternalApiFootballDataProvider` verifica si el equipo ya tiene suficientes partidos en BD antes de disparar una petición.
- **Cache de Configuración:** Los límites diarios se gestionan en una tabla `configuration` persistente.
- **Llamadas Batch:** La importación se realiza por selección, guardando los últimos 5 resultados de forma atómica.

## Versiones fijadas (para reproducibilidad)
- Quarkus BOM: `3.17.5`
- PostgreSQL: `16`
- Node base imagen frontend: `node:22-alpine`
- Maven imagen backend: `maven:3.9-eclipse-temurin-21`
- nginx: `nginx:1.27-alpine`
