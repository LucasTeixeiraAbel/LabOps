#!/bin/bash

set -e

echo "Iniciando PostgreSQL..."

if ! systemctl is-active --quiet docker.service; then
    echo "Docker não está rodando. Iniciando Docker..."
    /opt/labops/modules/docker/start.sh
fi

if [ ! -f /opt/labops/config/postgres/postgres.env ]; then
    echo "Configuração do PostgreSQL não encontrada."
    echo "Executando instalação/preparação..."
    /opt/labops/modules/postgres/install.sh
fi

sudo docker compose -f /opt/labops/compose/postgres.yml up -d

echo
echo "PostgreSQL iniciado."
echo "Acesso local no servidor:"
echo "  Host: 127.0.0.1"
echo "  Porta: 5432"
echo "  Banco: labops"
echo "  Usuário: labops"
