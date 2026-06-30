#!/bin/bash

echo "========================================"
echo "        LABOPS - DOCKER DISK USAGE"
echo "========================================"
echo

if ! systemctl is-active --quiet docker.service; then
    echo "Docker não está em execução."
    echo "Use o menu Docker para iniciar o serviço."
    exit 1
fi

sudo docker system df
