#!/bin/bash

echo "========================================"
echo "        LABOPS - NGINX STATUS"
echo "========================================"
echo

if sudo docker ps --format '{{.Names}}' | grep -q '^labops-nginx$'; then
    echo "Nginx Gateway: Running"
    echo
    sudo docker ps --filter "name=labops-nginx" --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
else
    echo "Nginx Gateway: Stopped"
fi
