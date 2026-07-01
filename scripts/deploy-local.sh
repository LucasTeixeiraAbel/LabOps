#!/bin/bash

set -e

PROJECT_DIR="$HOME/Projects/LabOps"
INSTALL_DIR="/opt/labops"

echo "========================================"
echo "          LABOPS LOCAL DEPLOY"
echo "========================================"
echo

echo "[1/6] Verificando diretórios..."

if [ ! -d "$PROJECT_DIR" ]; then
    echo "ERRO: Diretório do projeto não encontrado: $PROJECT_DIR"
    exit 1
fi

if [ ! -d "$INSTALL_DIR" ]; then
    echo "Criando diretório de instalação: $INSTALL_DIR"
    sudo mkdir -p "$INSTALL_DIR"
fi

echo "[2/6] Criando estrutura base..."

sudo mkdir -p "$INSTALL_DIR"/{bin,core,modules,compose,config,docs,assets,scripts,www}
sudo mkdir -p "$INSTALL_DIR"/{runtime,logs,backups,data,temp}
sudo mkdir -p "$INSTALL_DIR"/runtime/{cache,tmp,pid,state}

echo "[3/6] Copiando arquivos do projeto..."

sudo rsync -av --delete "$PROJECT_DIR/bin/" "$INSTALL_DIR/bin/"
sudo rsync -av --delete "$PROJECT_DIR/core/" "$INSTALL_DIR/core/"
sudo rsync -av --delete "$PROJECT_DIR/modules/" "$INSTALL_DIR/modules/"
sudo rsync -av --delete "$PROJECT_DIR/compose/" "$INSTALL_DIR/compose/"
sudo rsync -av --delete "$PROJECT_DIR/docs/" "$INSTALL_DIR/docs/"
sudo rsync -av --delete "$PROJECT_DIR/assets/" "$INSTALL_DIR/assets/"
sudo rsync -av --delete "$PROJECT_DIR/scripts/" "$INSTALL_DIR/scripts/"
sudo rsync -av "$PROJECT_DIR/VERSION" "$INSTALL_DIR/VERSION"
sudo rsync -av --delete "$PROJECT_DIR/www/" "$INSTALL_DIR/www/"

echo "[4/6] Aplicando configuração..."

sudo mkdir -p "$INSTALL_DIR/config"

if [ ! -f "$INSTALL_DIR/config/labops.conf" ]; then
    sudo rsync -av "$PROJECT_DIR/config/labops.conf" "$INSTALL_DIR/config/" 2>/dev/null || true
else
    echo "Configuração principal preservada: $INSTALL_DIR/config/labops.conf"
fi

sudo rsync -av --delete "$PROJECT_DIR/config/nginx/" "$INSTALL_DIR/config/nginx/" 2>/dev/null || true

echo "[5/6] Ajustando permissões..."

sudo chmod +x "$INSTALL_DIR/bin/labops"
sudo chmod +x "$INSTALL_DIR/core/"*.sh 2>/dev/null || true
sudo chmod +x "$INSTALL_DIR/scripts/"*.sh 2>/dev/null || true

sudo chown -R root:labops "$INSTALL_DIR" 2>/dev/null || sudo chown -R root:root "$INSTALL_DIR"
sudo chmod -R 775 "$INSTALL_DIR"

echo "[6/6] Atualizando comando global..."

sudo ln -sf "$INSTALL_DIR/bin/labops" /usr/local/bin/labops

echo
echo "Deploy local concluído com sucesso!"
echo
echo "Execute:"
echo "  labops"
echo
