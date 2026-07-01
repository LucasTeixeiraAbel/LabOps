#!/bin/bash

set -e

COMPOSE_PROJECT="labops-postgres"
COMPOSE_FILE="/opt/labops/compose/postgres.yml"

echo "Parando PostgreSQL..."

sudo docker compose -p "$COMPOSE_PROJECT" -f "$COMPOSE_FILE" down

if sudo docker ps -a --format '{{.Names}}' | grep -q '^labops-postgres$'; then
    echo "Container labops-postgres ainda existe fora do projeto Compose atual."
    echo "Removendo container antigo. Os dados serão preservados."
    sudo docker stop labops-postgres >/dev/null 2>&1 || true
    sudo docker rm labops-postgres >/dev/null 2>&1 || true
fi

echo "PostgreSQL parado."
echo "Os dados permanecem preservados em /opt/labops/data/postgres."
