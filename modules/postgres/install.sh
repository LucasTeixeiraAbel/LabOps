#!/bin/bash

set -e

echo "========================================"
echo "      LABOPS - INSTALL POSTGRESQL"
echo "========================================"
echo

ENV_DIR="/opt/labops/config/postgres"
ENV_FILE="$ENV_DIR/postgres.env"
DATA_DIR="/opt/labops/data/postgres"
BACKUP_DIR="/opt/labops/backups/postgres"

if ! systemctl is-active --quiet docker.service; then
    echo "Docker não está rodando. Iniciando Docker..."
    /opt/labops/modules/docker/start.sh
fi

echo "Criando diretórios do PostgreSQL..."
sudo mkdir -p "$ENV_DIR" "$DATA_DIR" "$BACKUP_DIR"

if [ ! -f "$ENV_FILE" ]; then
    echo "Criando arquivo de configuração seguro: $ENV_FILE"

    POSTGRES_PASSWORD="$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 24)"

    sudo tee "$ENV_FILE" >/dev/null <<EOF_ENV
POSTGRES_DB=labops
POSTGRES_USER=labops
POSTGRES_PASSWORD=$POSTGRES_PASSWORD
EOF_ENV

    sudo chmod 600 "$ENV_FILE"

    echo
    echo "Configuração criada com sucesso."
    echo "Usuário padrão: labops"
    echo "Banco padrão:   labops"
    echo "Senha gerada automaticamente e salva em:"
    echo "$ENV_FILE"
else
    echo "Arquivo de configuração já existe. Mantendo configuração atual:"
    echo "$ENV_FILE"
fi

echo
echo "Baixando imagem postgres:16-alpine..."
sudo docker pull postgres:16-alpine

echo
echo "PostgreSQL preparado com sucesso."
