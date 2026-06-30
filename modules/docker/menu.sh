#!/bin/bash

docker_menu() {

    while true; do

        clear
        show_banner

        print_header "DOCKER MODULE"

        echo -e "${COLOR_GREEN}[ 1 ]${COLOR_RESET} Status do Docker"
        echo -e "${COLOR_GREEN}[ 2 ]${COLOR_RESET} Instalar Docker"
        echo -e "${COLOR_GREEN}[ 3 ]${COLOR_RESET} Iniciar Docker"
        echo -e "${COLOR_YELLOW}[ 4 ]${COLOR_RESET} Parar Docker"
        echo -e "${COLOR_YELLOW}[ 5 ]${COLOR_RESET} Atualizar Docker"
        echo -e "${COLOR_BLUE}[ 6 ]${COLOR_RESET} Testar hello-world"
        echo
        echo -e "${COLOR_RED}[ 0 ]${COLOR_RESET} Voltar"
        echo

        print_line

        read -p "Escolha uma opção: " docker_option

        echo

        case "$docker_option" in
            1)
                log_info "Consultando status do Docker."
                "$LABOPS_HOME/modules/docker/status.sh"
                pause_screen
                ;;
            2)
                log_info "Executando instalação do Docker pelo menu."
                "$LABOPS_HOME/modules/docker/install.sh"
                pause_screen
                ;;
            3)
                log_info "Iniciando Docker pelo menu."
                "$LABOPS_HOME/modules/docker/start.sh"
                pause_screen
                ;;
            4)
                log_warn "Parando Docker pelo menu."
                "$LABOPS_HOME/modules/docker/stop.sh"
                pause_screen
                ;;
            5)
                log_info "Atualizando Docker pelo menu."
                "$LABOPS_HOME/modules/docker/update.sh"
                pause_screen
                ;;
            6)
                log_info "Executando teste hello-world do Docker."
                sudo docker run hello-world
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
