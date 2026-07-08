#!/bin/bash

echo "========================================"
echo "      LABOPS - MONITORING STATUS"
echo "========================================"
echo

docker ps \
  --filter "name=labops-prometheus" \
  --filter "name=labops-grafana" \
  --filter "name=labops-node-exporter" \
  --filter "name=labops-cadvisor" \
  --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"

echo
echo "Testes HTTP:"
echo

if curl -fsS http://localhost:9091/-/ready >/dev/null 2>&1; then
    echo "Prometheus: Running"
else
    echo "Prometheus: Stopped or not ready"
fi

if curl -fsS http://localhost:3000/api/health >/dev/null 2>&1; then
    echo "Grafana...: Running"
else
    echo "Grafana...: Stopped or not ready"
fi

if curl -fsS http://localhost:9100/metrics >/dev/null 2>&1; then
    echo "Node Exporter: Running"
else
    echo "Node Exporter: Stopped or not ready"
fi

if curl -fsS http://localhost:8081/metrics >/dev/null 2>&1; then
    echo "cAdvisor.: Running"
else
    echo "cAdvisor.: Stopped or not ready"
fi

echo
echo "Prometheus targets:"
echo

if curl -fsS http://localhost:9091/api/v1/targets \
    | grep -q '"job":"cadvisor".*"health":"up"'; then
    echo "cAdvisor target: UP"
else
    echo "cAdvisor target: verificar no Prometheus"
fi
