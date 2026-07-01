#!/bin/bash

set -e

COMPOSE_PROJECT="labops-postgres"
COMPOSE_FILE="/opt/labops/compose/postgres.yml"

echo "Atualizando PostgreSQL..."

sudo docker pull postgres:16-alpine
sudo docker compose -p "$COMPOSE_PROJECT" -f "$COMPOSE_FILE" up -d

echo "PostgreSQL atualizado."
