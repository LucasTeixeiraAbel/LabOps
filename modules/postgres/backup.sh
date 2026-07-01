#!/bin/bash

set -e

BACKUP_DIR="/opt/labops/backups/postgres"
TIMESTAMP="$(date +%F-%H%M%S)"
BACKUP_FILE="$BACKUP_DIR/labops-postgres-$TIMESTAMP.sql.gz"

echo "========================================"
echo "       LABOPS - POSTGRESQL BACKUP"
echo "========================================"
echo

if ! sudo docker ps --format '{{.Names}}' | grep -q '^labops-postgres$'; then
    echo "PostgreSQL não está rodando."
    echo "Inicie o serviço antes de gerar backup."
    exit 1
fi

sudo mkdir -p "$BACKUP_DIR"

echo "Gerando backup em:"
echo "$BACKUP_FILE"
echo

sudo docker exec labops-postgres sh -c 'pg_dump -U "$POSTGRES_USER" "$POSTGRES_DB"' | gzip | sudo tee "$BACKUP_FILE" >/dev/null

sudo chown root:labops "$BACKUP_FILE" 2>/dev/null || true
sudo chmod 640 "$BACKUP_FILE"

echo "Backup concluído."
ls -lh "$BACKUP_FILE"
