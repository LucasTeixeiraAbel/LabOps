#!/bin/bash

config_load() {
    CONFIG_FILE="$LABOPS_HOME/config/labops.conf"

    if [ -f "$CONFIG_FILE" ]; then
        source "$CONFIG_FILE"
        log_info "Arquivo de configuração carregado: $CONFIG_FILE"
    else
        log_warn "Arquivo de configuração não encontrado: $CONFIG_FILE"
    fi

    # Fonte oficial da versão do LabOps.
    # Mesmo que labops.conf antigo tenha LABOPS_VERSION=1.0.0,
    # o arquivo VERSION sempre vence.
    if [ -f "$LABOPS_HOME/VERSION" ]; then
        LABOPS_VERSION="$(cat "$LABOPS_HOME/VERSION")"
    else
        LABOPS_VERSION="v0.0.0 - Unknown"
    fi

    export LABOPS_VERSION
}
