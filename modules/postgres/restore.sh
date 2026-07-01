#!/bin/bash

set -e

BACKUP_DIR="/opt/labops/backups/postgres"

echo "========================================"
echo "       LABOPS - POSTGRESQL RESTORE"
echo "========================================"
echo

if ! sudo docker ps --format '{{.Names}}' | grep -q '^labops-postgres$'; then
    echo "PostgreSQL não está rodando."
    echo "Inicie o serviço antes de restaurar backup."
    exit 1
fi

if [ -n "$1" ]; then
    BACKUP_FILE="$1"
else
    echo "Backups disponíveis:"
    echo
    ls -lh "$BACKUP_DIR"/*.sql.gz 2>/dev/null || {
        echo "Nenhum backup encontrado em $BACKUP_DIR"
        exit 1
    }

    echo
    read -p "Informe o caminho completo do backup para restaurar: " BACKUP_FILE
fi

if [ ! -f "$BACKUP_FILE" ]; then
    echo "Arquivo não encontrado:"
    echo "$BACKUP_FILE"
    exit 1
fi

echo
echo "ATENÇÃO:"
echo "Este restore irá executar o SQL do backup no banco atual."
echo "Dependendo do conteúdo, dados existentes podem ser alterados."
echo

read -p "Deseja continuar? (s/N): " confirm

case "$confirm" in
    s|S)
        echo
        echo "Restaurando backup:"
        echo "$BACKUP_FILE"

        zcat "$BACKUP_FILE" | sudo docker exec -i labops-postgres sh -c 'psql -U "$POSTGRES_USER" "$POSTGRES_DB"'

        echo
        echo "Restore concluído."
        ;;
    *)
        echo "Operação cancelada."
        ;;
esac
