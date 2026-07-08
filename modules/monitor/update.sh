#!/bin/bash

set -e

echo "Atualizando imagens de monitoramento..."

docker compose \
  -f /opt/labops/compose/monitor.yml \
  --project-name labops-monitor \
  pull

docker compose \
  -f /opt/labops/compose/monitor.yml \
  --project-name labops-monitor \
  up -d

echo "Monitoramento atualizado."
