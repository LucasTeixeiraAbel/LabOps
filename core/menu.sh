#!/bin/bash

show_menu() {

    echo
    echo -e "${COLOR_CYAN}Menu Principal${COLOR_RESET}"
    echo
    echo -e "${COLOR_GREEN}[ 1 ]${COLOR_RESET} Start Lite"
    echo -e "${COLOR_GREEN}[ 2 ]${COLOR_RESET} Start Full"
    echo
    echo -e "${COLOR_YELLOW}[ 3 ]${COLOR_RESET} Docker"
    echo -e "${COLOR_YELLOW}[ 4 ]${COLOR_RESET} Banco de Dados"
    echo -e "${COLOR_YELLOW}[ 5 ]${COLOR_RESET} Monitoramento"
    echo -e "${COLOR_YELLOW}[ 6 ]${COLOR_RESET} IA Offline"
    echo
    echo -e "${COLOR_BLUE}[ 7 ]${COLOR_RESET} Status Geral"
    echo -e "${COLOR_BLUE}[ 8 ]${COLOR_RESET} Documentação"
    echo -e "${COLOR_BLUE}[ 9 ]${COLOR_RESET} Configurações"
    echo
    echo -e "${COLOR_RED}[ 0 ]${COLOR_RESET} Sair"
    echo
    print_line

    read -p "Escolha uma opção: " opcao

    echo

    case "$opcao" in
        1)
            echo -e "${COLOR_YELLOW}Start Lite ainda será implementado.${COLOR_RESET}"
            ;;
        2)
            echo -e "${COLOR_YELLOW}Start Full ainda será implementado.${COLOR_RESET}"
            ;;
        3)
            echo -e "${COLOR_YELLOW}Módulo Docker ainda será implementado.${COLOR_RESET}"
            ;;
        4)
            echo -e "${COLOR_YELLOW}Módulo Banco de Dados ainda será implementado.${COLOR_RESET}"
            ;;
        5)
            echo -e "${COLOR_YELLOW}Módulo Monitoramento ainda será implementado.${COLOR_RESET}"
            ;;
        6)
            echo -e "${COLOR_YELLOW}Módulo IA Offline ainda será implementado.${COLOR_RESET}"
            ;;
        7)
            echo -e "${COLOR_CYAN}Status Geral do LabOps${COLOR_RESET}"
            echo
            echo "Hostname : $SERVER_HOSTNAME"
            echo "IP       : $SERVER_IP"
            echo "RAM      : $MEMORY_USAGE"
            echo "Disco    : $DISK_USAGE"
            echo "Temp     : $CPU_TEMP"
            echo "Docker   : $DOCKER_STATUS"
            ;;
        8)
            echo -e "${COLOR_YELLOW}Documentação ainda será implementada.${COLOR_RESET}"
            ;;
        9)
            echo -e "${COLOR_YELLOW}Configurações ainda serão implementadas.${COLOR_RESET}"
            ;;
        0)
            echo -e "${COLOR_GREEN}Saindo do LabOps...${COLOR_RESET}"
            exit 0
            ;;
        *)
            echo -e "${COLOR_RED}Opção inválida.${COLOR_RESET}"
            ;;
    esac

    echo
}
