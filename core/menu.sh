#!/bin/bash

get_server_ip() {
    hostname -I | awk '{print $1}'
}

run_script_if_exists() {
    local script_path="$1"
    local script_label="$2"

    if [ -x "$script_path" ]; then
        "$script_path"
    else
        echo
        echo -e "${COLOR_RED}Script não encontrado ou sem permissão:${COLOR_RESET}"
        echo "$script_path"
        echo
        echo -e "${COLOR_YELLOW}Ação não executada: $script_label${COLOR_RESET}"
    fi
}

show_system_overview() {
    clear
    show_banner

    print_header "STATUS DO SISTEMA"

    echo -e "${COLOR_CYAN}Host:${COLOR_RESET}      $(hostname)"
    echo -e "${COLOR_CYAN}Usuário:${COLOR_RESET}   $(whoami)"
    echo -e "${COLOR_CYAN}IP:${COLOR_RESET}        $(get_server_ip)"
    echo -e "${COLOR_CYAN}Uptime:${COLOR_RESET}    $(uptime -p)"
    echo

    print_section "Memória"
    free -h

    echo
    print_section "Disco"
    df -h /

    echo
    print_section "Carga do sistema"
    uptime

    echo
    print_section "Docker"

    if systemctl is-active --quiet docker.service; then
        echo -e "Docker Service: ${COLOR_GREEN}Running${COLOR_RESET}"
    else
        echo -e "Docker Service: ${COLOR_RED}Stopped${COLOR_RESET}"
    fi

    if command -v docker >/dev/null 2>&1; then
        docker --version 2>/dev/null || sudo docker --version 2>/dev/null
    else
        echo -e "${COLOR_YELLOW}Docker CLI não encontrado.${COLOR_RESET}"
    fi

    echo
    print_section "Gateway / Nginx"

    if sudo docker ps --format '{{.Names}}' 2>/dev/null | grep -q '^labops-nginx$'; then
        echo -e "Nginx Gateway: ${COLOR_GREEN}Running${COLOR_RESET}"
        echo -e "URL local: ${COLOR_CYAN}http://$(get_server_ip):8080${COLOR_RESET}"
    else
        echo -e "Nginx Gateway: ${COLOR_RED}Stopped${COLOR_RESET}"
    fi

    echo
    print_section "Portas principais"

    sudo ss -ltnp 2>/dev/null | grep -E ':80|:8080' || echo "Nenhuma porta 80/8080 em escuta."

    pause_screen
}

show_config_screen() {
    clear
    show_banner

    print_header "CONFIGURAÇÕES DO LABOPS"

    echo -e "${COLOR_CYAN}LABOPS_HOME:${COLOR_RESET} ${LABOPS_HOME}"
    echo -e "${COLOR_CYAN}Versão:${COLOR_RESET}      ${LABOPS_VERSION}"
    echo

    print_section "Arquivo principal"

    if [ -f "$LABOPS_HOME/config/labops.conf" ]; then
        echo -e "${COLOR_GREEN}Encontrado:${COLOR_RESET} $LABOPS_HOME/config/labops.conf"
        echo
        cat "$LABOPS_HOME/config/labops.conf"
    else
        echo -e "${COLOR_YELLOW}Arquivo labops.conf não encontrado.${COLOR_RESET}"
    fi

    echo
    print_section "Configuração Nginx"

    if [ -f "$LABOPS_HOME/config/nginx/conf.d/default.conf" ]; then
        echo -e "${COLOR_GREEN}Encontrado:${COLOR_RESET} $LABOPS_HOME/config/nginx/conf.d/default.conf"
        echo
        cat "$LABOPS_HOME/config/nginx/conf.d/default.conf"
    else
        echo -e "${COLOR_YELLOW}Configuração Nginx não encontrada.${COLOR_RESET}"
    fi

    pause_screen
}

open_docker_menu() {
    if [ -f "$LABOPS_HOME/modules/docker/menu.sh" ]; then
        log_info "Abrindo módulo Docker."
        source "$LABOPS_HOME/modules/docker/menu.sh"
        docker_menu
    else
        echo
        echo -e "${COLOR_RED}Módulo Docker não encontrado.${COLOR_RESET}"
        pause_screen
    fi
}

open_nginx_menu() {
    if [ -f "$LABOPS_HOME/modules/nginx/menu.sh" ]; then
        log_info "Abrindo módulo Nginx Gateway."
        source "$LABOPS_HOME/modules/nginx/menu.sh"
        nginx_menu
    else
        echo
        echo -e "${COLOR_RED}Módulo Nginx não encontrado.${COLOR_RESET}"
        pause_screen
    fi
}


open_postgres_menu() {
    if [ -f "$LABOPS_HOME/modules/postgres/menu.sh" ]; then
        log_info "Abrindo módulo PostgreSQL."
        source "$LABOPS_HOME/modules/postgres/menu.sh"
        postgres_menu
    else
        echo
        echo -e "${COLOR_RED}Módulo PostgreSQL não encontrado.${COLOR_RESET}"
        pause_screen
    fi
}


open_monitor_menu() {
    if [ -f "$LABOPS_HOME/modules/monitor/menu.sh" ]; then
        log_info "Abrindo módulo Monitoramento."
        source "$LABOPS_HOME/modules/monitor/menu.sh"
        monitor_menu
    else
        echo
        echo -e "${COLOR_RED}Módulo Monitoramento não encontrado.${COLOR_RESET}"
        pause_screen
    fi
}

quick_start_menu() {
    while true; do
        clear
        show_banner

        print_header "INICIALIZAÇÃO RÁPIDA"

        echo -e "${COLOR_GREEN}[ 1 ]${COLOR_RESET} Iniciar Docker"
        echo -e "${COLOR_GREEN}[ 2 ]${COLOR_RESET} Iniciar Gateway / Nginx"
        echo -e "${COLOR_GREEN}[ 3 ]${COLOR_RESET} Iniciar tudo"
        echo
        echo -e "${COLOR_YELLOW}[ 4 ]${COLOR_RESET} Reiniciar Gateway / Nginx"
        echo -e "${COLOR_YELLOW}[ 5 ]${COLOR_RESET} Parar Gateway / Nginx"
        echo
        echo -e "${COLOR_BLUE}[ 6 ]${COLOR_RESET} Abrir menu Docker"
        echo -e "${COLOR_BLUE}[ 7 ]${COLOR_RESET} Abrir menu Gateway / Nginx"
        echo
        echo -e "${COLOR_RED}[ 0 ]${COLOR_RESET} Voltar"
        echo

        print_line

        read -p "Escolha uma opção: " quick_option

        echo

        case "$quick_option" in
            1)
                log_info "Inicialização rápida: iniciando Docker."
                run_script_if_exists "$LABOPS_HOME/modules/docker/start.sh" "Iniciar Docker"
                pause_screen
                ;;
            2)
                log_info "Inicialização rápida: iniciando Nginx Gateway."
                run_script_if_exists "$LABOPS_HOME/modules/nginx/start.sh" "Iniciar Gateway / Nginx"
                pause_screen
                ;;
            3)
                log_info "Inicialização rápida: iniciando todos os serviços essenciais."
                run_script_if_exists "$LABOPS_HOME/modules/docker/start.sh" "Iniciar Docker"
                echo
                run_script_if_exists "$LABOPS_HOME/modules/nginx/start.sh" "Iniciar Gateway / Nginx"
                echo
                echo -e "${COLOR_GREEN}Serviços essenciais processados.${COLOR_RESET}"
                echo -e "Acesse: ${COLOR_CYAN}http://$(get_server_ip):8080${COLOR_RESET}"
                pause_screen
                ;;
            4)
                log_warn "Inicialização rápida: reiniciando Nginx Gateway."
                run_script_if_exists "$LABOPS_HOME/modules/nginx/stop.sh" "Parar Gateway / Nginx"
                echo
                run_script_if_exists "$LABOPS_HOME/modules/nginx/start.sh" "Iniciar Gateway / Nginx"
                pause_screen
                ;;
            5)
                log_warn "Inicialização rápida: parando Nginx Gateway."
                run_script_if_exists "$LABOPS_HOME/modules/nginx/stop.sh" "Parar Gateway / Nginx"
                pause_screen
                ;;
            6)
                open_docker_menu
                ;;
            7)
                open_nginx_menu
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

logs_menu() {
    while true; do
        clear
        show_banner

        print_header "LOGS E DIAGNÓSTICO"

        echo -e "${COLOR_GREEN}[ 1 ]${COLOR_RESET} Logs do LabOps"
        echo -e "${COLOR_GREEN}[ 2 ]${COLOR_RESET} Logs do Nginx Gateway"
        echo -e "${COLOR_GREEN}[ 3 ]${COLOR_RESET} Status dos containers Docker"
        echo
        echo -e "${COLOR_YELLOW}[ 4 ]${COLOR_RESET} Journal do Docker"
        echo -e "${COLOR_YELLOW}[ 5 ]${COLOR_RESET} Diagnóstico de portas 80/8080"
        echo -e "${COLOR_YELLOW}[ 6 ]${COLOR_RESET} Regras NAT relacionadas à porta 80"
        echo
        echo -e "${COLOR_RED}[ 0 ]${COLOR_RESET} Voltar"
        echo

        print_line

        read -p "Escolha uma opção: " logs_option

        echo

        case "$logs_option" in
            1)
                log_info "Exibindo logs do LabOps."
                clear
                show_banner
                print_header "LOGS DO LABOPS"

                if [ -f "$LABOPS_HOME/logs/labops.log" ]; then
                    tail -n 100 "$LABOPS_HOME/logs/labops.log"
                else
                    echo -e "${COLOR_YELLOW}Nenhum log encontrado em:${COLOR_RESET}"
                    echo "$LABOPS_HOME/logs/labops.log"
                fi

                pause_screen
                ;;
            2)
                log_info "Exibindo logs do Nginx Gateway."
                clear
                show_banner
                print_header "LOGS DO NGINX GATEWAY"

                if sudo docker ps -a --format '{{.Names}}' 2>/dev/null | grep -q '^labops-nginx$'; then
                    sudo docker logs labops-nginx --tail 100
                else
                    echo -e "${COLOR_YELLOW}Container labops-nginx não encontrado.${COLOR_RESET}"
                fi

                pause_screen
                ;;
            3)
                log_info "Exibindo containers Docker."
                clear
                show_banner
                print_header "CONTAINERS DOCKER"

                sudo docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" 2>/dev/null || echo "Não foi possível listar containers."

                pause_screen
                ;;
            4)
                log_info "Exibindo journal do Docker."
                clear
                show_banner
                print_header "JOURNAL DOCKER"

                sudo journalctl -u docker.service -n 100 --no-pager

                pause_screen
                ;;
            5)
                log_info "Executando diagnóstico de portas."
                clear
                show_banner
                print_header "DIAGNÓSTICO DE PORTAS"

                echo "Portas 80 e 8080:"
                echo
                sudo ss -ltnp | grep -E ':80|:8080' || echo "Nenhuma porta 80/8080 em escuta."

                echo
                echo "Teste localhost:8080:"
                curl -I http://localhost:8080/ 2>/dev/null || echo "Falha ao acessar localhost:8080"

                echo
                echo "Teste IP do servidor:8080:"
                curl -I "http://$(get_server_ip):8080/" 2>/dev/null || echo "Falha ao acessar IP do servidor:8080"

                pause_screen
                ;;
            6)
                log_info "Exibindo regras NAT relacionadas à porta 80."
                clear
                show_banner
                print_header "REGRAS NAT - PORTA 80"

                sudo iptables -t nat -S | grep -E 'dport 80|DOCKER|PREROUTING|OUTPUT|KUBE|CNI' || echo "Nenhuma regra encontrada."

                pause_screen
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

show_future_module_message() {
    local module_name="$1"

    echo
    echo -e "${COLOR_YELLOW}Módulo $module_name ainda será implementado.${COLOR_RESET}"
    echo
    echo "Ele já está reservado no roadmap do LabOps."
    pause_screen
}

show_menu() {
    while true; do
        clear
        show_banner

        print_header "MENU PRINCIPAL"

        echo -e "${COLOR_GREEN}[ 1 ]${COLOR_RESET} Status do Sistema"
        echo -e "${COLOR_GREEN}[ 2 ]${COLOR_RESET} Configurações"
        echo
        echo -e "${COLOR_GREEN}[ 3 ]${COLOR_RESET} Docker"
        echo -e "${COLOR_GREEN}[ 4 ]${COLOR_RESET} Gateway / Nginx"
        echo
        echo -e "${COLOR_BLUE}[ 5 ]${COLOR_RESET} Inicialização rápida"
        echo -e "${COLOR_BLUE}[ 6 ]${COLOR_RESET} Logs e diagnóstico"
        echo
        echo -e "${COLOR_GREEN}[ 7 ]${COLOR_RESET} Banco de Dados / PostgreSQL"
        echo -e "${COLOR_GREEN}[ 8 ]${COLOR_RESET} Monitoramento"
        echo -e "${COLOR_YELLOW}[ 9 ]${COLOR_RESET} IA Offline"
        echo
        echo -e "${COLOR_RED}[ 0 ]${COLOR_RESET} Sair"
        echo

        print_line

        read -p "Escolha uma opção: " option

        echo

        case "$option" in
            1)
                log_info "Abrindo status do sistema."
                show_system_overview
                ;;
            2)
                log_info "Abrindo configurações do LabOps."
                show_config_screen
                ;;
            3)
                open_docker_menu
                ;;
            4)
                open_nginx_menu
                ;;
            5)
                log_info "Abrindo inicialização rápida."
                quick_start_menu
                ;;
            6)
                log_info "Abrindo logs e diagnóstico."
                logs_menu
                ;;
            7)
                open_postgres_menu
                ;;
            8)
                open_monitor_menu
                ;;
            9)
                log_warn "Módulo IA Offline ainda não implementado."
                show_future_module_message "IA Offline"
                ;;
            0)
                log_info "LabOps finalizado pelo usuário."
                echo -e "${COLOR_GREEN}Saindo do LabOps...${COLOR_RESET}"
                echo
                exit 0
                ;;
            *)
                echo -e "${COLOR_RED}Opção inválida.${COLOR_RESET}"
                pause_screen
                ;;
        esac
    done
}
