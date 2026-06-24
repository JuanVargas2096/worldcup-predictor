# Índice de Contexto — World Cup Predictor 2026

> Esta carpeta documenta **TODO** lo que se construye en el proyecto para que
> cualquier IA o desarrollador pueda continuar el trabajo sin pérdida de contexto.
> Si retomas el proyecto, **lee primero `09-progreso-y-pendientes.md`**.

## Documentos

| Archivo | Contenido |
|---------|-----------|
| [01-objetivo-y-alcance.md](01-objetivo-y-alcance.md) | Qué se construye y por qué. Alcance del MVP. |
| [02-decisiones-tecnicas.md](02-decisiones-tecnicas.md) | Stack, versiones, decisiones y trade-offs. |
| [03-modelo-datos.md](03-modelo-datos.md) | Esquema de base de datos (tablas, relaciones). |
| [04-modelo-scoring.md](04-modelo-scoring.md) | Algoritmo de puntaje y probabilidad. |
| [05-backend-estructura.md](05-backend-estructura.md) | Estructura del backend Quarkus, endpoints. |
| [06-frontend-estructura.md](06-frontend-estructura.md) | Estructura del frontend Angular (SPA). |
| [07-datos-reales-mundial-2026.md](07-datos-reales-mundial-2026.md) | Datos reales: 48 equipos y grupos A–L. Fuentes. |
| [08-como-ejecutar.md](08-como-ejecutar.md) | Cómo levantar todo con Docker / en local. |
| [09-progreso-y-pendientes.md](09-progreso-y-pendientes.md) | **Bitácora de avance y TODOs.** Empieza aquí. |
| [10-despliegue.md](10-despliegue.md) | Despliegue: registry propio, docker-compose, GitHub Actions. |

## Resumen de una línea

WebApp (Angular SPA + Quarkus + PostgreSQL) que calcula un ranking de
probabilidad de ganar la Copa del Mundo 2026 y muestra el fixture real de la
fase de grupos a partir de los 48 clasificados.
