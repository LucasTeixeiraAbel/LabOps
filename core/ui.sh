#!/bin/bash

# Cores do LabOps
COLOR_RESET="\033[0m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_YELLOW="\033[1;33m"
COLOR_CYAN="\033[1;36m"
COLOR_WHITE="\033[1;37m"
COLOR_GRAY="\033[0;37m"

print_line() {
    echo -e "${COLOR_BLUE}══════════════════════════════════════════════════════════════${COLOR_RESET}"
}

print_section() {
    echo -e "${COLOR_CYAN}$1${COLOR_RESET}"
}

status_dot() {
    local status="$1"

    if [ "$status" = "Running" ]; then
        echo -e "${COLOR_GREEN}● Running${COLOR_RESET}"
    elif [ "$status" = "Stopped" ]; then
        echo -e "${COLOR_RED}● Stopped${COLOR_RESET}"
    else
        echo -e "${COLOR_YELLOW}● $status${COLOR_RESET}"
    fi
}

show_banner() {

    clear

    echo -e "${COLOR_BLUE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                                                              ║"
    echo "║      ██╗      █████╗ ██████╗  ██████╗ ██████╗ ███████╗       ║"
    echo "║      ██║     ██╔══██╗██╔══██╗██╔═══██╗██╔══██╗██╔════╝       ║"
    echo "║      ██║     ███████║██████╔╝██║   ██║██████╔╝███████╗       ║"
    echo "║      ██║     ██╔══██║██╔══██╗██║   ██║██╔═══╝ ╚════██║       ║"
    echo "║      ███████╗██║  ██║██████╔╝╚██████╔╝██║     ███████║       ║"
    echo "║      ╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝     ╚══════╝       ║"
    echo "║                                                              ║"
    echo "║              DevOps Laboratory Platform                     ║"
    echo "║                    Version $LABOPS_VERSION - Foundation                  ║"
    echo "║                                                              ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${COLOR_RESET}"

    echo -e "${COLOR_WHITE}Servidor:${COLOR_RESET} ${COLOR_CYAN}$SERVER_HOSTNAME${COLOR_RESET}"
    echo -e "${COLOR_WHITE}Usuário..:${COLOR_RESET} $SERVER_USER"
    echo -e "${COLOR_WHITE}IP.......:${COLOR_RESET} $SERVER_IP"
    echo -e "${COLOR_WHITE}Uptime...:${COLOR_RESET} $SERVER_UPTIME"
    echo -e "${COLOR_WHITE}Data.....:${COLOR_RESET} $SERVER_DATE"
    echo

    print_line
    echo -e "${COLOR_WHITE}RAM......:${COLOR_RESET} $MEMORY_USAGE"
    echo -e "${COLOR_WHITE}Disco....:${COLOR_RESET} $DISK_USAGE"
    echo -e "${COLOR_WHITE}Carga....:${COLOR_RESET} $LOAD_AVG"
    echo -e "${COLOR_WHITE}Temp.....:${COLOR_RESET} $CPU_TEMP"
    echo -e "${COLOR_WHITE}Docker...:${COLOR_RESET} $(status_dot "$DOCKER_STATUS")"
    print_line
}
pause_screen() {
    echo
    read -p "Pressione ENTER para voltar ao menu..."
}

print_header() {
    echo
    print_line
    echo -e "${COLOR_CYAN}$1${COLOR_RESET}"
    print_line
}
