#!/bin/bash

echo "Iniciando Docker..."

sudo systemctl daemon-reload
sudo systemctl enable --now containerd.service
sudo systemctl enable --now docker.socket
sudo systemctl reset-failed docker.service || true
sudo systemctl start docker.service

echo "Docker iniciado."
