#!/bin/bash

set -e

echo "Parando PostgreSQL..."

sudo docker compose -f /opt/labops/compose/postgres.yml down

echo "PostgreSQL parado."
echo "Os dados permanecem preservados em /opt/labops/data/postgres."
