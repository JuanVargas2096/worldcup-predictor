# ⚽ Predictor Mundial 2026

WebApp que estima **qué selección tiene más probabilidad de ganar la Copa del
Mundo 2026** y muestra el **fixture real de la fase de grupos** a partir de los
48 equipos clasificados.

- **Backend**: Java 21 · Quarkus 3 · PostgreSQL · Flyway · REST.
- **Frontend**: Angular 19 (SPA) · TailwindCSS · Chart.js.
- **Infra**: Docker Compose (db + backend + frontend).

> Los **equipos y grupos son reales** (sorteo oficial del 05-dic-2025).
> La forma reciente de cada selección es **simulada** para el MVP, detrás de una
> interfaz `FootballDataProvider` lista para conectar una API real.
> Documentación completa del proyecto en la carpeta [`contexto/`](contexto/00-INDICE.md).

## 🚀 Ejecutar con un solo comando

Requisito: Docker + Docker Compose.

```bash
cd worldcup-predictor
docker compose up --build
```

Luego abre:

| Servicio | URL |
|---|---|
| Frontend (app) | http://localhost:4200 |
| Backend (API) | http://localhost:8080/api/rankings |
| Health | http://localhost:8080/q/health |
| PostgreSQL | localhost:5432 (worldcup / worldcup) |

El backend, al arrancar, crea el esquema (Flyway), siembra los 48 equipos
reales, genera el fixture de grupos, simula la forma reciente y calcula el
ranking. No hay pasos manuales.

## 🧠 Cómo funciona el modelo

Cada selección recibe un score 0–100:

```
score = 40% forma(últimos 5) + 20% dif. goles + 15% fuerza rivales
      + 15% Mundial anterior  + 10% ELO/ranking
```

La **probabilidad de título** se obtiene con un softmax sobre los scores (suma
100% entre las 48). Los pesos son **configurables** desde la pantalla de
Configuración (deben sumar 100%). Detalle en
[`contexto/04-modelo-scoring.md`](contexto/04-modelo-scoring.md).

## 🖥️ Pantallas (SPA)

1. **Ranking** (`/ranking`): tabla de favoritos, score, probabilidad, últimos 5.
2. **Detalle** (`/equipo/:id`): stats, desglose del score, explicación, gráfico
   de evolución, últimos partidos.
3. **Fixture** (`/fixture`): los 12 grupos (A–L) con equipos y calendario.
4. **Configuración** (`/configuracion`): editar pesos del modelo.

## 📡 Sincronización de Datos Reales

Para obtener los partidos reales y alimentar el modelo de scoring:

1. **Vía UI**: Ve a la pantalla de **Configuración** y usa el botón **Importar partidos ahora** (requiere configurar `FOOTBALL_API_KEY` en el `docker-compose.yml` o `.env`).
2. **Vía Script (Recomendado si falla la API en Docker)**:
   Usa el script de bash incluido para generar una semilla SQL persistente:
   ```bash
   ./import_matches.sh TU_API_KEY
   ```
   Esto creará un archivo de migración en `backend/src/main/resources/db/migration/V8__seed_matches.sql`. Al reiniciar los contenedores (`docker compose up --build`), los datos se cargarán automáticamente.

## 📡 Endpoints principales

### Mundial 2026 (Real-time)
- **POST** `/api/world-cup/sync`: Dispara la sincronización manual.
- **GET** `/api/world-cup/fixtures`: Consulta partidos reales del mundial.
  - Filtros: `season`, `teamId`, `status`, `round`, `dateFrom`, `dateTo`.
- **GET** `/api/world-cup/bracket`: Bracket de eliminatorias con predicciones por partido
  (% de avanzar de cada equipo y los 2 posibles rivales de la siguiente fase). Solo lectura de BD.
- **POST** `/api/world-cup/predictions/refresh`: Refresca las predicciones (HTTP a `/predictions`,
  acotado por la cuota diaria). También lo dispara el scheduler tras cada sincronización.

### Predictor & Ranking
```
GET  /api/teams                         GET  /api/rankings
GET  /api/teams/{id}                     GET  /api/rankings/{teamId}
POST /api/teams                          POST /api/rankings/recalculate
PUT  /api/teams/{id}                     GET  /api/scoring-config
DELETE /api/teams/{id}                   PUT  /api/scoring-config
GET  /api/matches                        GET  /api/groups
GET  /api/matches/team/{teamId}/last-five
POST /api/matches                        GET  /api/fixtures
POST /api/matches/import                 GET  /api/fixtures/group/{letter}
```

## 🏆 Sincronización Copa Mundial 2026

El sistema incluye un proceso automático para obtener resultados y calendarios reales:
1. **Configuración**: El parámetro `WORLD_CUP_SYNC_RUNS_PER_DAY` en la tabla `app_parameter` define la frecuencia diaria (default: 6).
2. **Intervalo**: El scheduler calcula `24 / N` horas para evitar saturar la API.
3. **Persistencia**: Se guardan equipos (`world_cup_team`) y partidos (`world_cup_fixture`) con el JSON original para auditoría.

## 🛠️ Desarrollo local (sin Docker para la app)

Necesitas **JDK 21** y **Node 20+**. La máquina de referencia tiene Java 11, por
eso el flujo recomendado es Docker. Si tienes JDK 21:

```bash
# Base de datos
docker compose up -d db

# Backend (modo dev con hot reload)
cd backend && ./mvnw quarkus:dev      # o: mvn quarkus:dev

# Frontend (otra terminal)
cd frontend && npm install && npm start   # http://localhost:4200 (proxy a 8080)
```

## 📂 Estructura

```
worldcup-predictor/
├── backend/      # Quarkus (REST, Panache, Flyway)
├── frontend/     # Angular SPA (standalone components)
├── contexto/     # Documentación viva del proyecto (LEER PRIMERO)
├── docker-compose.yml
└── README.md
```

## 🔭 Mejoras futuras
Integrar API real (API-Football/Sportmonks), importar CSV histórico, modelo ELO
propio, simulación Monte Carlo del bracket, login/admin. Ver
[`contexto/09-progreso-y-pendientes.md`](contexto/09-progreso-y-pendientes.md).
