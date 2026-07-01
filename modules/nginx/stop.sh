#!/bin/bash

set -e

echo "Parando Nginx Gateway..."

sudo docker compose -f /opt/labops/compose/nginx.yml down

echo "Nginx Gateway parado."
