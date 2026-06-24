#!/usr/bin/env bash
#
# Levanta TODO el stack (PostgreSQL + backend Quarkus + frontend nginx).
# En la primera ejecución la BD está vacía: Flyway crea el esquema y siembra los
# datos (48 selecciones, grupos, fixtures, config) y el backend genera la forma
# inicial y calcula el ranking. No requiere pasos manuales.
#
# Uso:
#   ./docker-compose.sh          -> build + up (segundo plano)
#   ./docker-compose.sh logs     -> sigue los logs
#   ./docker-compose.sh down     -> detiene
#   ./docker-compose.sh reset    -> detiene y BORRA la BD (volumen)

set -euo pipefail
cd "$(dirname "$0")"

# Permite usar 'docker compose' (v2) o 'docker-compose' (v1)
if docker compose version >/dev/null 2>&1; then
  DC="docker compose"
else
  DC="docker-compose"
fi

case "${1:-up}" in
  up)
    if [ ! -f .env ]; then
      cp .env.example .env
      echo "==> Creado .env desde .env.example."
      echo "    (Edita FOOTBALL_API_KEY en .env si quieres datos reales del Mundial.)"
    fi
    echo "==> Construyendo e iniciando servicios..."
    $DC up --build -d
    echo ""
    echo "==> Servicios arriba:"
    $DC ps
    echo ""
    echo "    Frontend : http://localhost:${FRONTEND_PORT:-4200}"
    echo "    API      : http://localhost:${BACKEND_PORT:-8080}/api/rankings"
    echo "    Health   : http://localhost:${BACKEND_PORT:-8080}/q/health"
    echo ""
    echo "    El backend tarda ~30-60s en migrar y sembrar la BD la primera vez."
    ;;
  logs)
    $DC logs -f
    ;;
  down)
    $DC down
    ;;
  reset)
    echo "==> Deteniendo y BORRANDO la base de datos (volumen)..."
    $DC down -v
    ;;
  *)
    echo "Uso: $0 {up|logs|down|reset}"
    exit 1
    ;;
esac
