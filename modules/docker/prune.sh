#!/bin/bash

echo "========================================"
echo "          LABOPS - DOCKER CLEANUP"
echo "========================================"
echo

if ! systemctl is-active --quiet docker.service; then
    echo "Docker não está em execução."
    echo "Use o menu Docker para iniciar o serviço."
    exit 1
fi

echo "Esta ação irá remover:"
echo
echo "- Containers parados"
echo "- Imagens não utilizadas"
echo "- Cache de build"
echo
echo "Volumes NÃO serão removidos nesta etapa."
echo

read -p "Deseja continuar? (s/N): " confirm

case "$confirm" in
    s|S)
        echo
        echo "Limpando containers parados..."
        sudo docker container prune -f

        echo
        echo "Limpando imagens não utilizadas..."
        sudo docker image prune -f

        echo
        echo "Limpando cache de build..."
        sudo docker builder prune -f

        echo
        echo "Limpeza concluída."
        ;;
    *)
        echo "Operação cancelada."
        ;;
esac
