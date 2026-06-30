#!/bin/bash

echo "========================================"
echo "        LABOPS - DOCKER CONTAINERS"
echo "========================================"
echo

if ! systemctl is-active --quiet docker.service; then
    echo "Docker não está em execução."
    echo "Use o menu Docker para iniciar o serviço."
    exit 1
fi

sudo docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
