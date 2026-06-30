#!/bin/bash

config_load() {

    CONFIG_FILE="$LABOPS_HOME/config/labops.conf"

    if [ -f "$CONFIG_FILE" ]; then
        source "$CONFIG_FILE"
        log_info "Arquivo de configuração carregado: $CONFIG_FILE"
    else
        log_warn "Arquivo de configuração não encontrado. Usando valores padrão."

        LABOPS_VERSION="1.0.0"
        HOSTNAME="srv.lab"
        MODE="lite"
        TIMEZONE="America/Sao_Paulo"
    fi
}
