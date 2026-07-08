#!/bin/bash

while true; do
    clear
    echo "========================================"
    echo "        LABOPS - MONITORAMENTO"
    echo "========================================"
    echo
    echo "[ 1 ] Status"
    echo "[ 2 ] Instalar/Preparar"
    echo "[ 3 ] Iniciar"
    echo "[ 4 ] Parar"
    echo "[ 5 ] Atualizar"
    echo
    echo "[ 0 ] Voltar"
    echo
    read -p "Escolha uma opção: " option

    case "$option" in
        1) /opt/labops/modules/monitor/status.sh; read -p "Pressione Enter para continuar..." ;;
        2) /opt/labops/modules/monitor/install.sh; read -p "Pressione Enter para continuar..." ;;
        3) /opt/labops/modules/monitor/start.sh; read -p "Pressione Enter para continuar..." ;;
        4) /opt/labops/modules/monitor/stop.sh; read -p "Pressione Enter para continuar..." ;;
        5) /opt/labops/modules/monitor/update.sh; read -p "Pressione Enter para continuar..." ;;
        0) break ;;
        *) echo "Opção inválida."; sleep 1 ;;
    esac
done
