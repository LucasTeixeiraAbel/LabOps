#!/bin/bash

set -e

echo "========================================"
echo "        LABOPS - INSTALL NGINX"
echo "========================================"
echo

if ! systemctl is-active --quiet docker.service; then
    echo "Docker não está rodando. Iniciando Docker..."
    /opt/labops/modules/docker/start.sh
fi

echo "Baixando imagem nginx:alpine..."
sudo docker pull nginx:alpine

echo
echo "Nginx preparado com sucesso."
echo "Use o menu para iniciar o Gateway."
