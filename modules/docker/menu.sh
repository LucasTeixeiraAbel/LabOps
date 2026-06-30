#!/bin/bash

docker_menu() {

    while true; do

        clear
        show_banner

        print_header "DOCKER MODULE"

        echo -e "${COLOR_GREEN}[ 1 ]${COLOR_RESET} Status do Docker"
        echo -e "${COLOR_GREEN}[ 2 ]${COLOR_RESET} Listar containers"
        echo -e "${COLOR_GREEN}[ 3 ]${COLOR_RESET} Listar imagens"
        echo -e "${COLOR_GREEN}[ 4 ]${COLOR_RESET} Uso de disco Docker"
        echo -e "${COLOR_BLUE}[ 5 ]${COLOR_RESET} Docker Doctor"
        echo
        echo -e "${COLOR_YELLOW}[ 6 ]${COLOR_RESET} Instalar Docker"
        echo -e "${COLOR_YELLOW}[ 7 ]${COLOR_RESET} Iniciar Docker"
        echo -e "${COLOR_YELLOW}[ 8 ]${COLOR_RESET} Parar Docker"
        echo -e "${COLOR_YELLOW}[ 9 ]${COLOR_RESET} Atualizar Docker"
        echo
        echo -e "${COLOR_BLUE}[10 ]${COLOR_RESET} Testar hello-world"
        echo -e "${COLOR_RED}[11 ]${COLOR_RESET} Limpeza segura"
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
                log_info "Listando containers Docker."
                "$LABOPS_HOME/modules/docker/containers.sh"
                pause_screen
                ;;
            3)
                log_info "Listando imagens Docker."
                "$LABOPS_HOME/modules/docker/images.sh"
                pause_screen
                ;;
            4)
                log_info "Consultando uso de disco do Docker."
                "$LABOPS_HOME/modules/docker/disk.sh"
                pause_screen
                ;;
            5)
                log_info "Executando Docker Doctor."
                "$LABOPS_HOME/modules/docker/doctor.sh"
                pause_screen
                ;;
            6)
                log_info "Executando instalação do Docker pelo menu."
                "$LABOPS_HOME/modules/docker/install.sh"
                pause_screen
                ;;
            7)
                log_info "Iniciando Docker pelo menu."
                "$LABOPS_HOME/modules/docker/start.sh"
                pause_screen
                ;;
            8)
                log_warn "Parando Docker pelo menu."
                "$LABOPS_HOME/modules/docker/stop.sh"
                pause_screen
                ;;
            9)
                log_info "Atualizando Docker pelo menu."
                "$LABOPS_HOME/modules/docker/update.sh"
                pause_screen
                ;;
            10)
                log_info "Executando teste hello-world do Docker."
                sudo docker run hello-world
                pause_screen
                ;;
            11)
                log_warn "Executando limpeza segura do Docker."
                "$LABOPS_HOME/modules/docker/prune.sh"
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
