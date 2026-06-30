#!/bin/bash

echo "========================================"
echo "        LABOPS - DOCKER STATUS"
echo "========================================"
echo

if systemctl is-active --quiet docker.socket; then
    echo "Docker Socket: Running"
else
    echo "Docker Socket: Stopped"
fi

if systemctl is-active --quiet containerd.service; then
    echo "Containerd....: Running"
else
    echo "Containerd....: Stopped"
fi

if systemctl is-active --quiet docker.service; then
    echo "Docker Engine.: Running"
    docker --version 2>/dev/null || true
    docker compose version 2>/dev/null || true
else
    echo "Docker Engine.: Stopped or not installed"
fi
