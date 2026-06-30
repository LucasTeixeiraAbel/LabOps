#!/bin/bash

labops_boot() {

    source "$LABOPS_HOME/core/logger.sh"
    source "$LABOPS_HOME/core/runtime.sh"
    source "$LABOPS_HOME/core/config.sh"
    source "$LABOPS_HOME/core/status.sh"
    source "$LABOPS_HOME/core/ui.sh"
    source "$LABOPS_HOME/core/menu.sh"

    runtime_init
    config_load
    load_system_status

    log_info "LabOps iniciado."

    show_banner
    show_menu

}
