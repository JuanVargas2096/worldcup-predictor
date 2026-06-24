# 10 — Despliegue (registry propio + nginx-proxy + GitHub Actions)

## Arquitectura en el servidor
Detrás de **jwilder/nginx-proxy + acme-companion** (red externa **`ranger`**):
- El **frontend** (nginx) lleva `VIRTUAL_HOST` / `LETSENCRYPT_HOST` → el proxy enruta el
  dominio y emite el certificado TLS. NO publica puertos (`expose: 80`).
- El frontend hace reverse-proxy de `/worldcup-service/` → `worldcup-backend:8080`.
- El **backend** Quarkus cuelga de su contexto **`quarkus.http.root-path=/worldcup-service`**
  (convención de los demás servicios). Interno, sin publicar puertos.
- La **BD** PostgreSQL está contenerizada (volumen `worldcup_pgdata`), también en `ranger`.
- Todos los contenedores están en la red `ranger` (external).

## Rutas
- Frontend SPA con **hash routing**: `https://<host>/#/ranking`, `/#/equipo/:id`, `/#/fixture`,
  `/#/mundial`, `/#/configuracion`.
- API (vía nginx → backend root-path): `https://<host>/worldcup-service/api/...`
- Health backend: `https://<host>/worldcup-service/q/health`
- Health frontend (interno): `/healthz`
- DNS público actual: **worldcup-predictions.mrvargas.net** (configurable con `PUBLIC_HOST`).

## Imágenes en el registry
- `registry.mrvargas.net/worldcup/backend:latest` (+ `:<git-sha>`)
- `registry.mrvargas.net/worldcup/frontend:latest` (+ `:<git-sha>`)

## Archivos de compose
- **`docker-compose.yml`** (raíz): desarrollo LOCAL (build + puertos publicados 4200/8080/5432,
  red por defecto). Para `./docker-compose.sh`.
- **`deploy/docker-compose.yml`**: SERVIDOR (imágenes del registry, `pull_policy: always`,
  red `ranger` externa, `VIRTUAL_HOST`/`LETSENCRYPT_HOST` en el frontend, sin publicar puertos).

## Variables (.env)
`cp .env.example .env` y ajustar. Claves: `REGISTRY`, `TAG`, `PUBLIC_HOST`,
`LETSENCRYPT_EMAIL`, `DB_*`, `BACKEND_PORT`, `FRONTEND_PORT`, `DATA_PROVIDER`,
`FOOTBALL_API_KEY`. **`.env` está en `.gitignore` (la key nunca se commitea).**

## Levantar en LOCAL
```bash
./docker-compose.sh        # build + up -d (crea .env si falta)
```
Frontend: http://localhost:4200  ·  API: http://localhost:8080/worldcup-service/api/rankings

## Desplegar en el SERVIDOR
Requiere que la red `ranger` y el nginx-proxy ya existan.
```bash
docker login registry.mrvargas.net
cp .env.example .env      # editar PUBLIC_HOST, FOOTBALL_API_KEY, credenciales BD
docker compose -f deploy/docker-compose.yml pull
docker compose -f deploy/docker-compose.yml up -d
```
Primer arranque con BD pelada: Flyway (V1..V10) crea esquema + siembra 48 selecciones,
grupos, fixtures y config; el backend genera la forma inicial (mock) y el ranking.
Sin pasos manuales y sin errores aunque no haya API key (datos simulados).

## CI/CD — GitHub Actions
`.github/workflows/build-and-push.yml` (push a main/master o manual) construye y publica
ambas imágenes. **Secrets requeridos**: `REGISTRY_USERNAME`, `REGISTRY_PASSWORD`.

## Actualización de datos (sin on-demand en la web)
- **Forma reciente (matches)**: `MatchImportScheduler`, cron `0 0 */6 * * ?` (cada 6h, usa `last`).
- **Fixtures reales del Mundial**: `WorldCupSyncScheduler` (N veces/día, `WORLD_CUP_SYNC_RUNS_PER_DAY`).
- Acotado por cuota diaria (`configuration.MAX_API_CALLS_PER_DAY`, default 100).
- La UI ya NO tiene botón de importación on-demand (eliminado de Configuración).
