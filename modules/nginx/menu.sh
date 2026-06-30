#!/bin/bash

nginx_menu() {

    while true; do

        clear
        show_banner

        print_header "NGINX GATEWAY MODULE"

        echo -e "${COLOR_GREEN}[ 1 ]${COLOR_RESET} Status do Nginx Gateway"
        echo -e "${COLOR_GREEN}[ 2 ]${COLOR_RESET} Preparar Nginx"
        echo -e "${COLOR_GREEN}[ 3 ]${COLOR_RESET} Iniciar Gateway"
        echo -e "${COLOR_YELLOW}[ 4 ]${COLOR_RESET} Parar Gateway"
        echo -e "${COLOR_YELLOW}[ 5 ]${COLOR_RESET} Atualizar Gateway"
        echo
        echo -e "${COLOR_BLUE}[ 6 ]${COLOR_RESET} Testar localhost:8080"
        echo -e "${COLOR_BLUE}[ 7 ]${COLOR_RESET} Testar IP do servidor"
        echo -e "${COLOR_BLUE}[ 8 ]${COLOR_RESET} Mostrar logs"
        echo
        echo -e "${COLOR_RED}[ 0 ]${COLOR_RESET} Voltar"
        echo

        print_line

        read -p "Escolha uma opção: " nginx_option

        echo

        case "$nginx_option" in
            1)
                log_info "Consultando status do Nginx Gateway."
                "$LABOPS_HOME/modules/nginx/status.sh"
                pause_screen
                ;;
            2)
                log_info "Preparando Nginx Gateway."
                "$LABOPS_HOME/modules/nginx/install.sh"
                pause_screen
                ;;
            3)
                log_info "Iniciando Nginx Gateway."
                "$LABOPS_HOME/modules/nginx/start.sh"
                pause_screen
                ;;
            4)
                log_warn "Parando Nginx Gateway."
                "$LABOPS_HOME/modules/nginx/stop.sh"
                pause_screen
                ;;
            5)
                log_info "Atualizando Nginx Gateway."
                "$LABOPS_HOME/modules/nginx/update.sh"
                pause_screen
                ;;
            6)
                log_info "Testando Nginx Gateway via localhost."
                curl -I http://localhost:8080/
                pause_screen
                ;;
            7)
                log_info "Testando Nginx Gateway via IP do servidor."
                SERVER_IP=$(hostname -I | awk '{print $1}')
                echo "Testando: http://$SERVER_IP:8080/"
                echo
                curl -I "http://$SERVER_IP:8080/"
                pause_screen
                ;;
            8)
                log_info "Exibindo logs do Nginx Gateway."
                sudo docker logs labops-nginx --tail 80
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
