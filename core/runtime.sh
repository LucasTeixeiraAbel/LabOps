#!/bin/bash

runtime_init() {

    mkdir -p "$LABOPS_HOME/runtime/cache"
    mkdir -p "$LABOPS_HOME/runtime/tmp"
    mkdir -p "$LABOPS_HOME/runtime/pid"
    mkdir -p "$LABOPS_HOME/runtime/state"
    mkdir -p "$LABOPS_HOME/logs"

    echo "$(date '+%Y-%m-%d %H:%M:%S')" > "$LABOPS_HOME/runtime/state/last_boot"

    log_info "Runtime inicializado com sucesso."
}
