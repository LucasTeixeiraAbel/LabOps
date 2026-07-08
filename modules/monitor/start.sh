#!/bin/bash

set -e

echo "Iniciando stack de monitoramento..."

docker network create labops-network 2>/dev/null || true

docker compose \
  -f /opt/labops/compose/monitor.yml \
  --project-name labops-monitor \
  up -d

echo
echo "Monitoramento iniciado."
echo
echo "Acessos:"
echo "  Prometheus: http://IP_DO_SERVIDOR:9091"
echo "  Grafana...: http://IP_DO_SERVIDOR:3000"
echo "  Node Exporter: http://IP_DO_SERVIDOR:9100/metrics"
