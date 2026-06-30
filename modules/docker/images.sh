#!/bin/bash

echo "========================================"
echo "          LABOPS - DOCKER IMAGES"
echo "========================================"
echo

if ! systemctl is-active --quiet docker.service; then
    echo "Docker não está em execução."
    echo "Use o menu Docker para iniciar o serviço."
    exit 1
fi

sudo docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.Size}}"
