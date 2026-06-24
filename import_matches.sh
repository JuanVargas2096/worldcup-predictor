#!/bin/bash

# Script para importar partidos reales desde API-Football y generar un SQL seed.
# Uso: ./import_matches.sh TU_API_KEY

API_KEY=$1
if [ -z "$API_KEY" ]; then
    echo "Error: Debes proporcionar tu API_KEY como primer argumento."
    echo "Uso: ./import_matches.sh TU_API_KEY"
    exit 1
fi

OUTPUT_FILE="backend/src/main/resources/db/migration/V8__seed_matches.sql"
API_URL="https://v3.football.api-sports.io/fixtures"

# Limpiar archivo de salida
echo "-- Semilla de partidos históricos generada el $(date)" > $OUTPUT_FILE
echo "-- Basado en API-Football v3" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Lista de IDs de equipos (obtenidos de V7__fix_all_api_ids.sql)
TEAM_IDS=(16 17 770 1531 5529 15 1569 1113 6 31 1108 2386 2384 777 20 2380 25 2382 1501 5530 1118 12 5 28 1 22 32 4673 9 7 23 1533 2 13 1090 1567 26 775 1532 1548 27 8 1568 1508 10 3 1504 11)

echo "Iniciando importación de partidos para ${#TEAM_IDS[@]} selecciones..."

for TEAM_ID in "${TEAM_IDS[@]}"; do
    echo "Obteniendo partidos para el equipo API_ID: $TEAM_ID..."
    
    # Consultar API (Temporada 2024 para compatibilidad con plan gratuito)
    RESPONSE=$(curl -s -H "x-apisports-key: $API_KEY" "$API_URL?team=$TEAM_ID&season=2024&status=FT")
    
    # Verificar errores en la respuesta
    ERRORS=$(echo $RESPONSE | grep -o '"errors":\[\]' | wc -l)
    if [ "$ERRORS" -eq 0 ] && [ "$(echo $RESPONSE | grep -o '"errors":{}' | wc -l)" -eq 0 ]; then
        echo "  [AVISO] La API devolvió errores para el equipo $TEAM_ID. Revisa tu cuota o clave."
        # Si la respuesta contiene un mensaje de error específico
        MSG=$(echo $RESPONSE | sed -n 's/.*"errors":{\([^}]*\)}.*/\1/p')
        echo "  Mensaje: $MSG"
        continue
    fi

    # Procesar cada partido de la respuesta
    if command -v jq >/dev/null 2>&1; then
        # Ordenar por fecha desc y tomar 5
        echo "$RESPONSE" | jq -c '.response | sort_by(.fixture.date) | reverse | .[0:5] | .[]' | while read -r match; do
            DATE=$(echo $match | jq -r '.fixture.date' | cut -d'T' -f1)
            HOME_ID=$(echo $match | jq -r '.teams.home.id')
            AWAY_ID=$(echo $match | jq -r '.teams.away.id')
            HOME_NAME=$(echo $match | jq -r '.teams.home.name' | sed "s/'/''/g")
            AWAY_NAME=$(echo $match | jq -r '.teams.away.name' | sed "s/'/''/g")
            HOME_SCORE=$(echo $match | jq -r '.goals.home')
            AWAY_SCORE=$(echo $match | jq -r '.goals.away')
            LEAGUE=$(echo $match | jq -r '.league.name' | sed "s/'/''/g")

            # Generar SQL
            # Primero nos aseguramos de que los equipos existan (si son externos)
            echo "INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('$HOME_NAME', 3)), '$HOME_NAME', '🏳️', $HOME_ID WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = $HOME_ID);" >> $OUTPUT_FILE
            echo "INSERT INTO teams (id, code, name, flag_emoji, api_id) SELECT gen_random_uuid(), UPPER(LEFT('$AWAY_NAME', 3)), '$AWAY_NAME', '🏳️', $AWAY_ID WHERE NOT EXISTS (SELECT 1 FROM teams WHERE api_id = $AWAY_ID);" >> $OUTPUT_FILE
            
            # Insertar el partido
            echo "INSERT INTO matches (id, match_date, home_team_id, away_team_id, home_score, away_score, competition, match_type, created_at) " >> $OUTPUT_FILE
            echo "SELECT gen_random_uuid(), '$DATE', (SELECT id FROM teams WHERE api_id = $HOME_ID), (SELECT id FROM teams WHERE api_id = $AWAY_ID), $HOME_SCORE, $AWAY_SCORE, '$LEAGUE', 'EXTERNAL', CURRENT_TIMESTAMP " >> $OUTPUT_FILE
            echo "WHERE NOT EXISTS (SELECT 1 FROM matches WHERE match_date = '$DATE' AND home_team_id = (SELECT id FROM teams WHERE api_id = $HOME_ID) AND away_team_id = (SELECT id FROM teams WHERE api_id = $AWAY_ID));" >> $OUTPUT_FILE
            echo "" >> $OUTPUT_FILE
        done
    else
        echo "  [ERROR] 'jq' no está instalado. El script requiere 'jq' para procesar el JSON de la API."
        exit 1
    fi

    # Pequeña pausa para no saturar la API (rate limit)
    sleep 1
done

echo "¡Listo! Se ha generado el archivo: $OUTPUT_FILE"
echo "Puedes aplicar esta migración reiniciando los contenedores de Docker."
