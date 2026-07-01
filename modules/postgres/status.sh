#!/bin/bash

echo "========================================"
echo "      LABOPS - POSTGRESQL STATUS"
echo "========================================"
echo

if sudo docker ps --format '{{.Names}}' | grep -q '^labops-postgres$'; then
    echo "PostgreSQL: Running"
    echo
    sudo docker ps --filter "name=labops-postgres" --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"

    echo
    echo "Healthcheck:"
    sudo docker inspect --format='{{.State.Health.Status}}' labops-postgres 2>/dev/null || echo "Healthcheck indisponível"

    echo
    echo "Teste pg_isready:"
    sudo docker exec labops-postgres sh -c 'pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"'
else
    echo "PostgreSQL: Stopped"
fi
