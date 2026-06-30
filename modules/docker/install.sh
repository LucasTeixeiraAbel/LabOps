#!/bin/bash

set -e

echo "========================================"
echo "        LABOPS - INSTALL DOCKER"
echo "========================================"
echo

echo "[1/7] Removendo versões antigas..."
sudo apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true

echo "[2/7] Atualizando pacotes..."
sudo apt-get update

echo "[3/7] Instalando dependências..."
sudo apt-get install -y ca-certificates curl gnupg

echo "[4/7] Configurando chave GPG oficial do Docker..."
sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "[5/7] Adicionando repositório oficial do Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "[6/7] Instalando Docker Engine e Compose Plugin..."
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[7/7] Habilitando serviço Docker..."
sudo systemctl daemon-reload
sudo systemctl enable --now containerd.service
sudo systemctl enable --now docker.socket
sudo systemctl enable docker.service
sudo systemctl reset-failed docker.service || true
sudo systemctl start docker.service

echo "Adicionando usuário atual ao grupo docker..."
sudo usermod -aG docker "$USER"

echo
echo "Docker instalado com sucesso!"
echo
echo "IMPORTANTE:"
echo "Saia do SSH e entre novamente para usar docker sem sudo."
echo
echo "Teste agora com:"
echo "  sudo docker run hello-world"
echo
