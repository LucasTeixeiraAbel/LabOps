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

echo
echo "Alertas Prometheus:"
echo

alerts_tmp="/tmp/labops-prometheus-alerts.json"

if curl -fsS http://localhost:9091/api/v1/alerts -o "$alerts_tmp" >/dev/null 2>&1; then
    python3 - "$alerts_tmp" <<'PYALERTS'
import json
import sys

path = sys.argv[1]

with open(path, "r", encoding="utf-8") as f:
    data = json.load(f)

alerts = data.get("data", {}).get("alerts", [])

if not alerts:
    print("Alertas ativos: 0")
else:
    print(f"Alertas ativos: {len(alerts)}")
    for alert in alerts:
        labels = alert.get("labels", {})
        annotations = alert.get("annotations", {})
        name = labels.get("alertname", "sem_nome")
        severity = labels.get("severity", "sem_severidade")
        state = alert.get("state", "unknown")
        summary = annotations.get("summary", "")

        print(f"- {name} [{severity}] [{state}] {summary}")
PYALERTS
    rm -f "$alerts_tmp"
else
    echo "Não foi possível consultar alertas no Prometheus."
fi

