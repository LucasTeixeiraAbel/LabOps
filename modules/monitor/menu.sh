#!/bin/bash

LABOPS_HOME="${LABOPS_HOME:-/opt/labops}"

# Carrega visual padrão do LabOps quando executado diretamente
if ! declare -F show_banner >/dev/null 2>&1; then
    [ -f "$LABOPS_HOME/core/ui.sh" ] && source "$LABOPS_HOME/core/ui.sh"
fi

if ! declare -F log_info >/dev/null 2>&1; then
    [ -f "$LABOPS_HOME/core/logger.sh" ] && source "$LABOPS_HOME/core/logger.sh"
fi

# Fallbacks caso o script seja executado isolado
COLOR_GREEN="${COLOR_GREEN:-\033[0;32m}"
COLOR_BLUE="${COLOR_BLUE:-\033[0;34m}"
COLOR_YELLOW="${COLOR_YELLOW:-\033[1;33m}"
COLOR_RED="${COLOR_RED:-\033[0;31m}"
COLOR_CYAN="${COLOR_CYAN:-\033[0;36m}"
COLOR_RESET="${COLOR_RESET:-\033[0m}"

if ! declare -F print_header >/dev/null 2>&1; then
    print_header() {
        echo "========================================"
        echo "        $1"
        echo "========================================"
    }
fi

if ! declare -F print_line >/dev/null 2>&1; then
    print_line() {
        echo "══════════════════════════════════════════════════════════════"
    }
fi

if ! declare -F pause_screen >/dev/null 2>&1; then
    pause_screen() {
        echo
        read -p "Pressione Enter para continuar..."
    }
fi

if ! declare -F log_info >/dev/null 2>&1; then
    log_info() { true; }
fi

if ! declare -F log_warn >/dev/null 2>&1; then
    log_warn() { true; }
fi

monitor_docker_cmd() {
    if docker ps >/dev/null 2>&1; then
        echo "docker"
    else
        echo "sudo docker"
    fi
}

monitor_show_access() {
    clear
    show_banner 2>/dev/null || true
    print_header "ACESSO AO GRAFANA"

    local env_file="$LABOPS_HOME/config/grafana/grafana.env"
    local user
    local password

    if [ ! -f "$env_file" ]; then
        echo -e "${COLOR_RED}Arquivo não encontrado:${COLOR_RESET}"
        echo "$env_file"
        pause_screen
        return
    fi

    if [ -r "$env_file" ]; then
        user="$(grep '^GF_SECURITY_ADMIN_USER=' "$env_file" | cut -d= -f2-)"
        password="$(grep '^GF_SECURITY_ADMIN_PASSWORD=' "$env_file" | cut -d= -f2-)"
    else
        user="$(sudo grep '^GF_SECURITY_ADMIN_USER=' "$env_file" | cut -d= -f2-)"
        password="$(sudo grep '^GF_SECURITY_ADMIN_PASSWORD=' "$env_file" | cut -d= -f2-)"
    fi

    echo -e "${COLOR_CYAN}URL NAT / Windows:${COLOR_RESET} http://localhost:3000"
    echo -e "${COLOR_CYAN}URL dentro da VM:${COLOR_RESET} http://localhost:3000"
    echo
    echo -e "${COLOR_CYAN}Usuário:${COLOR_RESET} ${user:-admin}"
    echo -e "${COLOR_CYAN}Senha..:${COLOR_RESET} ${password:-não encontrada}"
    echo
    echo -e "${COLOR_YELLOW}Atenção:${COLOR_RESET} não compartilhe print desta tela."
    echo

    pause_screen
}

monitor_reset_grafana_password() {
    clear
    show_banner 2>/dev/null || true
    print_header "RESETAR SENHA DO GRAFANA"

    local docker_cmd
    docker_cmd="$(monitor_docker_cmd)"

    if ! $docker_cmd ps --format '{{.Names}}' | grep -q '^labops-grafana$'; then
        echo -e "${COLOR_RED}Container labops-grafana não está rodando.${COLOR_RESET}"
        echo
        echo "Inicie o monitoramento antes de resetar a senha:"
        echo "$LABOPS_HOME/modules/monitor/start.sh"
        pause_screen
        return
    fi

    echo "Digite uma nova senha ou pressione Enter para gerar automaticamente."
    echo
    read -s -p "Nova senha: " new_password
    echo

    if [ -z "$new_password" ]; then
        new_password="$(openssl rand -hex 16)"
        echo
        echo -e "${COLOR_YELLOW}Senha automática gerada.${COLOR_RESET}"
    fi

    echo
    echo "Resetando senha dentro do container..."

    if $docker_cmd exec labops-grafana grafana cli admin reset-admin-password "$new_password"; then
        echo
        echo -e "${COLOR_GREEN}Senha do Grafana resetada com sucesso.${COLOR_RESET}"
    else
        echo
        echo -e "${COLOR_RED}Falha ao resetar senha do Grafana.${COLOR_RESET}"
        pause_screen
        return
    fi

    echo
    echo "Atualizando arquivo grafana.env..."

    sudo env NEW_PASSWORD="$new_password" python3 - <<'PY'
from pathlib import Path
import os

path = Path("/opt/labops/config/grafana/grafana.env")
new_password = os.environ["NEW_PASSWORD"]

lines = []
found = False

if path.exists():
    lines = path.read_text().splitlines()

new_lines = []
for line in lines:
    if line.startswith("GF_SECURITY_ADMIN_PASSWORD="):
        new_lines.append(f"GF_SECURITY_ADMIN_PASSWORD={new_password}")
        found = True
    else:
        new_lines.append(line)

if not found:
    new_lines.append(f"GF_SECURITY_ADMIN_PASSWORD={new_password}")

path.write_text("\n".join(new_lines) + "\n")
PY

    sudo chown root:labops "$LABOPS_HOME/config/grafana/grafana.env"
    sudo chmod 640 "$LABOPS_HOME/config/grafana/grafana.env"

    echo
    echo -e "${COLOR_CYAN}Usuário:${COLOR_RESET} admin"
    echo -e "${COLOR_CYAN}Nova senha:${COLOR_RESET} $new_password"
    echo
    echo -e "${COLOR_YELLOW}Guarde essa senha em local seguro.${COLOR_RESET}"

    pause_screen
}

monitor_show_urls() {
    clear
    show_banner 2>/dev/null || true
    print_header "URLS DO MONITORAMENTO"

    echo -e "${COLOR_CYAN}Grafana:${COLOR_RESET}"
    echo "  http://localhost:3000"
    echo
    echo -e "${COLOR_CYAN}Prometheus:${COLOR_RESET}"
    echo "  http://localhost:9091"
    echo
    echo -e "${COLOR_CYAN}Node Exporter:${COLOR_RESET}"
    echo "  http://localhost:9100/metrics"
    echo
    echo -e "${COLOR_CYAN}Gateway LabOps:${COLOR_RESET}"
    echo "  http://localhost:8080"
    echo

    pause_screen
}

monitor_menu() {
    while true; do
        clear
        show_banner 2>/dev/null || true

        print_header "MONITORAMENTO / OBSERVABILITY"

        echo -e "${COLOR_GREEN}[ 1 ]${COLOR_RESET} Status"
        echo -e "${COLOR_GREEN}[ 2 ]${COLOR_RESET} Instalar / Preparar"
        echo -e "${COLOR_GREEN}[ 3 ]${COLOR_RESET} Iniciar"
        echo -e "${COLOR_GREEN}[ 4 ]${COLOR_RESET} Parar"
        echo -e "${COLOR_GREEN}[ 5 ]${COLOR_RESET} Atualizar"
        echo
        echo -e "${COLOR_BLUE}[ 6 ]${COLOR_RESET} Informações de login do Grafana"
        echo -e "${COLOR_YELLOW}[ 7 ]${COLOR_RESET} Resetar senha do Grafana"
        echo -e "${COLOR_BLUE}[ 8 ]${COLOR_RESET} Mostrar URLs de acesso"
        echo
        echo -e "${COLOR_RED}[ 0 ]${COLOR_RESET} Voltar"
        echo

        print_line

        read -p "Escolha uma opção: " option
        echo

        case "$option" in
            1)
                log_info "Monitoramento: status."
                "$LABOPS_HOME/modules/monitor/status.sh"
                pause_screen
                ;;
            2)
                log_info "Monitoramento: instalar/preparar."
                "$LABOPS_HOME/modules/monitor/install.sh"
                pause_screen
                ;;
            3)
                log_info "Monitoramento: iniciar."
                "$LABOPS_HOME/modules/monitor/start.sh"
                pause_screen
                ;;
            4)
                log_warn "Monitoramento: parar."
                "$LABOPS_HOME/modules/monitor/stop.sh"
                pause_screen
                ;;
            5)
                log_info "Monitoramento: atualizar."
                "$LABOPS_HOME/modules/monitor/update.sh"
                pause_screen
                ;;
            6)
                monitor_show_access
                ;;
            7)
                monitor_reset_grafana_password
                ;;
            8)
                monitor_show_urls
                ;;
            0)
                return
                ;;
            *)
                echo -e "${COLOR_RED}Opção inválida.${COLOR_RESET}"
                pause_screen
                ;;
        esac
    done
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    monitor_menu
fi
