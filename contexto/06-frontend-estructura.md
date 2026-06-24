# 06 — Estructura del Frontend (Angular SPA)

Raíz: `frontend/`. Angular 18 standalone (sin NgModules), TailwindCSS, Chart.js.

## Archivos clave (`src/`)

```
main.ts                      bootstrapApplication(AppComponent, appConfig)
index.html / styles.css      Tailwind directives en styles.css
app/
  app.config.ts              provideRouter + provideHttpClient
  app.routes.ts              rutas con loadComponent (lazy)
  app.component.ts           layout raíz: nav + <router-outlet>
  models/models.ts           interfaces TS (espejo de los DTOs del backend)
  core/api.service.ts        HttpClient hacia '/api'
  components/
    form-badges.component.ts badges W/D/L de los últimos 5
  pages/
    ranking/ranking.component.ts        tabla de favoritos + recalcular
    team-detail/team-detail.component.ts detalle + gráfico Chart.js
    fixture/fixture.component.ts         12 grupos A-L + calendario
    config/config.component.ts           sliders de pesos (suma 100%)
```

## Rutas (SPA)
- `/ranking` (default), `/equipo/:id`, `/fixture`, `/configuracion`.
- Wildcard `**` → ranking.

## Comunicación con la API
- `ApiService` usa base `'/api'`.
- **Producción**: nginx (`frontend/nginx.conf`) hace `proxy_pass` de `/api/` a
  `http://backend:8080/api/` (mismo origen, sin CORS).
- **Desarrollo** (`npm start`): `proxy.conf.json` redirige `/api` a `localhost:8080`.

## Gráfico de evolución
`team-detail` usa **Chart.js directo** (no ng2-charts, para evitar conflictos de
peer-deps): `new Chart(canvas, {...})` en `renderChart()`. Se dibuja cuando hay
≥2 snapshots de score (recalcular varias veces para verlo).

## Estilos
TailwindCSS vía `tailwind.config.js` + `postcss.config.js`. Colores custom
`night` y `pitch`.

## Build
Multi-stage Docker (`frontend/Dockerfile`): node compila (`dist/worldcup/browser`),
nginx sirve. No requiere Node/Angular CLI local.
