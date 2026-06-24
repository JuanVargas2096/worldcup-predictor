# 08 — Cómo Ejecutar

## Opción recomendada: Docker (un comando)

Requisito: Docker + Docker Compose.

```bash
cd worldcup-predictor
docker compose up --build
```

Servicios:
- Frontend: http://localhost:4200
- Backend API: http://localhost:8080/api/rankings
- Health: http://localhost:8080/q/health
- PostgreSQL: localhost:5432 (worldcup/worldcup)

El backend ejecuta Flyway (esquema + 48 equipos reales), genera el fixture,
simula forma reciente y calcula el ranking automáticamente al arrancar.

### Comandos útiles
```bash
docker compose up --build -d     # en segundo plano
docker compose logs -f backend   # ver logs del backend
docker compose down              # detener
docker compose down -v           # detener y borrar datos (volumen)
```

## Opción desarrollo (hot reload) — requiere JDK 21 y Node 20+

> La máquina de referencia tiene **Java 11**; para `quarkus:dev` se necesita
> **JDK 21**. Si no lo tienes, usa Docker.

```bash
# 1) Solo la base de datos
docker compose up -d db

# 2) Backend en modo dev
cd backend
mvn quarkus:dev        # http://localhost:8080

# 3) Frontend en modo dev (otra terminal)
cd frontend
npm install
npm start              # http://localhost:4200 (proxy /api -> 8080)
```

## Verificación rápida
```bash
curl http://localhost:8080/api/rankings | head
curl http://localhost:8080/api/groups   | head
curl http://localhost:8080/q/health
```

## Cambiar a datos reales (futuro)
1. Implementar `ExternalApiFootballDataProvider` (ver doc 05).
2. Definir `FOOTBALL_API_KEY` y `DATA_PROVIDER=external` en `docker-compose.yml`.
3. `POST /api/matches/import` para traer resultados, luego
   `POST /api/rankings/recalculate`.

## Riesgo conocido
El proyecto **no se ha compilado en esta máquina** (sin Docker/Maven/Node CLI).
Si `docker compose up --build` arroja errores de compilación, corrígelos y
actualiza `09-progreso-y-pendientes.md`.
