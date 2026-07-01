#!/bin/bash

set -e

echo "Atualizando PostgreSQL..."

sudo docker pull postgres:16-alpine
sudo docker compose -f /opt/labops/compose/postgres.yml up -d

echo "PostgreSQL atualizado."
