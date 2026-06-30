#!/bin/bash

set -e

echo "Iniciando Nginx Gateway..."

if ! systemctl is-active --quiet docker.service; then
    echo "Docker não está rodando. Iniciando Docker..."
    /opt/labops/modules/docker/start.sh
fi

sudo docker compose -f /opt/labops/compose/nginx.yml up -d

echo "Nginx Gateway iniciado."
echo
echo "Acesse:"
echo "  http://IP_DO_SERVIDOR:8080"
echo "  http://srv.lab:8080 após configurar DNS/hosts"
