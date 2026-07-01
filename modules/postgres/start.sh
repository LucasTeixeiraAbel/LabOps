#!/bin/bash

set -e

COMPOSE_PROJECT="labops-postgres"
COMPOSE_FILE="/opt/labops/compose/postgres.yml"
DATA_DIR="/opt/labops/data/postgres"
BACKUP_DIR="/opt/labops/backups/postgres"
ENV_FILE="/opt/labops/config/postgres/postgres.env"
NETWORK_NAME="labops-network"

echo "Iniciando PostgreSQL..."

if ! systemctl is-active --quiet docker.service; then
    echo "Docker não está rodando. Iniciando Docker..."
    /opt/labops/modules/docker/start.sh
fi

if [ ! -f "$ENV_FILE" ]; then
    echo "Configuração do PostgreSQL não encontrada."
    echo "Executando instalação/preparação..."
    /opt/labops/modules/postgres/install.sh
fi

sudo mkdir -p "$DATA_DIR" "$BACKUP_DIR"

if ! sudo docker network inspect "$NETWORK_NAME" >/dev/null 2>&1; then
    echo "Criando rede Docker compartilhada: $NETWORK_NAME"
    sudo docker network create "$NETWORK_NAME" >/dev/null
fi

PG_UID="$(sudo docker run --rm --entrypoint sh postgres:16-alpine -c 'id -u postgres')"
PG_GID="$(sudo docker run --rm --entrypoint sh postgres:16-alpine -c 'id -g postgres')"

echo "Ajustando permissões do volume PostgreSQL..."
sudo chown -R "$PG_UID:$PG_GID" "$DATA_DIR"
sudo chmod 700 "$DATA_DIR"

EXISTING_PROJECT="$(sudo docker inspect -f '{{ index .Config.Labels "com.docker.compose.project" }}' labops-postgres 2>/dev/null || true)"

if [ -n "$EXISTING_PROJECT" ] && [ "$EXISTING_PROJECT" != "$COMPOSE_PROJECT" ]; then
    echo "Container labops-postgres encontrado com projeto Compose antigo: $EXISTING_PROJECT"
    echo "Removendo container antigo. Os dados serão preservados em $DATA_DIR."
    sudo docker stop labops-postgres >/dev/null 2>&1 || true
    sudo docker rm labops-postgres >/dev/null 2>&1 || true
fi

sudo docker compose -p "$COMPOSE_PROJECT" -f "$COMPOSE_FILE" up -d

echo
echo "Aguardando PostgreSQL ficar pronto..."

for attempt in $(seq 1 30); do
    if sudo docker exec labops-postgres sh -c 'pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"' >/dev/null 2>&1; then
        echo "PostgreSQL pronto para conexões."
        echo
        echo "PostgreSQL iniciado."
        echo "Acesso local no servidor:"
        echo "  Host: 127.0.0.1"
        echo "  Porta: 5432"
        echo "  Banco: labops"
        echo "  Usuário: labops"
        exit 0
    fi

    echo "Aguardando... tentativa $attempt/30"
    sleep 2
done

echo
echo "PostgreSQL iniciou, mas ainda não respondeu ao teste de conexão."
echo "Verifique os logs com:"
echo "  sudo docker logs labops-postgres --tail 100"
exit 1
