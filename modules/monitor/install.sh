#!/bin/bash

set -e

LABOPS_HOME="/opt/labops"

echo "========================================"
echo "     LABOPS - INSTALL MONITORING"
echo "========================================"
echo

echo "[1/5] Criando diretórios..."
sudo mkdir -p "$LABOPS_HOME/data/prometheus"
sudo mkdir -p "$LABOPS_HOME/data/grafana"
sudo mkdir -p "$LABOPS_HOME/config/prometheus"
sudo mkdir -p "$LABOPS_HOME/config/grafana"

echo "[2/5] Criando rede Docker padrão..."
docker network create labops-network 2>/dev/null || true

echo "[3/5] Criando arquivo real do Grafana, se não existir..."
if [ ! -f "$LABOPS_HOME/config/grafana/grafana.env" ]; then
    GRAFANA_PASS="$(openssl rand -base64 18)"

    sudo tee "$LABOPS_HOME/config/grafana/grafana.env" > /dev/null <<EOG
GF_SECURITY_ADMIN_USER=admin
GF_SECURITY_ADMIN_PASSWORD=$GRAFANA_PASS
GF_USERS_ALLOW_SIGN_UP=false
EOG

    sudo chown root:labops "$LABOPS_HOME/config/grafana/grafana.env"
    sudo chmod 640 "$LABOPS_HOME/config/grafana/grafana.env"

    echo
    echo "Senha inicial do Grafana gerada."
    echo "Usuário: admin"
    echo "Senha salva em: $LABOPS_HOME/config/grafana/grafana.env"
fi

echo "[4/5] Ajustando permissões dos volumes..."
sudo chown -R 65534:65534 "$LABOPS_HOME/data/prometheus"
sudo chown -R 472:472 "$LABOPS_HOME/data/grafana"

echo "[5/5] Instalação do módulo de monitoramento concluída."
echo
echo "Acessos após iniciar:"
echo "  Prometheus: http://IP_DO_SERVIDOR:9090"
echo "  Grafana...: http://IP_DO_SERVIDOR:3000"
