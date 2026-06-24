# 10 — Despliegue (registry propio + Docker + GitHub Actions)

## Componentes contenerizados
- **db**: PostgreSQL 16 (volumen `worldcup_pgdata`). En el primer arranque está vacía;
  Flyway crea el esquema y siembra datos, el backend genera forma inicial y ranking.
- **backend**: Quarkus (build multi-stage con JDK 21 dentro del contenedor).
- **frontend**: Angular compilado y servido por **nginx** (build multi-stage), con proxy
  `/api` → `backend:8080` (ver `frontend/nginx.conf`).

## Imágenes en el registry propio
- `registry.mrvargas.net/worldcup/backend:latest`
- `registry.mrvargas.net/worldcup/frontend:latest`
(además del tag `:<git-sha>` por cada build de CI)

## Variables de entorno (.env)
`cp .env.example .env` y ajustar. Claves:
- `REGISTRY`, `TAG`
- `DB_NAME`, `DB_USERNAME`, `DB_PASSWORD`, `DB_PORT`
- `BACKEND_PORT`, `FRONTEND_PORT`
- `DATA_PROVIDER` (mock | external)
- `FOOTBALL_API_KEY` (API-Football; sin key la app usa datos simulados y NO falla)
**`.env` está en `.gitignore`: la API key y credenciales nunca se commitean.**

## Levantar todo (incluida la BD)
```bash
./docker-compose.sh          # build + up -d (crea .env si no existe)
./docker-compose.sh logs     # seguir logs
./docker-compose.sh down     # detener
./docker-compose.sh reset    # detener + borrar volumen de BD
```
Primera vez: la BD arranca pelada; Flyway (V1..V10) crea esquema + siembra 48 selecciones,
grupos, fixtures y config; el backend genera la forma inicial (mock) y el ranking.
No hay pasos manuales. Datos reales del Mundial: el cron los importa cada 6h (si hay key).

## CI/CD — GitHub Actions
Workflow: `.github/workflows/build-and-push.yml` (push a main/master o manual).
Construye y publica backend y frontend en `registry.mrvargas.net`.

**Secrets requeridos** (Settings → Secrets and variables → Actions):
- `REGISTRY_USERNAME` = `juan.vargas`
- `REGISTRY_PASSWORD` = (password del registry)

> Las credenciales SOLO van como secrets de GitHub, nunca en archivos del repo.

## Publicar imágenes manualmente (alternativa a CI)
```bash
docker login registry.mrvargas.net          # usuario juan.vargas
docker compose build
docker compose push
```

## Desplegar en el servidor (desde el registry)
Con `docker-compose.yml` + `.env` en el servidor:
```bash
docker login registry.mrvargas.net
docker compose pull
docker compose up -d
```

## Actualización de datos (sin on-demand en la web)
- **Forma reciente (matches)**: `MatchImportScheduler` — cron `0 0 */6 * * ?` (cada 6h).
- **Fixtures reales del Mundial**: `WorldCupSyncScheduler` — N veces/día (`WORLD_CUP_SYNC_RUNS_PER_DAY`, default 6).
- Acotado por cuota diaria (`configuration.MAX_API_CALLS_PER_DAY`, default 100).
- Ya NO existe botón de importación on-demand en la web (eliminado de la pantalla de Configuración).
- Endpoints REST de admin siguen existiendo (`POST /api/matches/import`, `POST /api/world-cup/sync`)
  para uso manual por curl si se necesita, pero la UI no los expone.
