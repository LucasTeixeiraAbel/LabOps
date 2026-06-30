#!/bin/bash

set -e

echo "Atualizando Nginx Gateway..."

sudo docker pull nginx:alpine
sudo docker compose -f /opt/labops/compose/nginx.yml up -d

echo "Nginx Gateway atualizado."
