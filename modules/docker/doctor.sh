#!/bin/bash

echo "========================================"
echo "          LABOPS - DOCKER DOCTOR"
echo "========================================"
echo

check_service() {
    local service="$1"
    local label="$2"

    if systemctl is-active --quiet "$service"; then
        echo "[OK]   $label está rodando."
    else
        echo "[WARN] $label não está rodando."
    fi
}

check_command() {
    local command_name="$1"
    local label="$2"

    if command -v "$command_name" >/dev/null 2>&1; then
        echo "[OK]   $label encontrado."
    else
        echo "[WARN] $label não encontrado."
    fi
}

check_service "containerd.service" "containerd.service"
check_service "docker.socket" "docker.socket"
check_service "docker.service" "docker.service"

echo

check_command "docker" "Docker CLI"

echo

if sudo docker info >/dev/null 2>&1; then
    echo "[OK]   Docker daemon respondendo corretamente."
else
    echo "[ERRO] Docker daemon não respondeu."
fi

if sudo docker compose version >/dev/null 2>&1; then
    echo "[OK]   Docker Compose Plugin funcionando."
else
    echo "[WARN] Docker Compose Plugin não respondeu."
fi

echo
echo "Versões:"
docker --version 2>/dev/null || true
docker compose version 2>/dev/null || true

echo
echo "Uso de disco Docker:"
sudo docker system df 2>/dev/null || true

echo
echo "Diagnóstico concluído."
