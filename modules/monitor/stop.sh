#!/bin/bash

set -e

echo "Parando stack de monitoramento..."

docker compose \
  -f /opt/labops/compose/monitor.yml \
  --project-name labops-monitor \
  down

echo "Monitoramento parado."
