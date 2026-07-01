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
    local box_width=62

    banner_empty_line() {
        printf "║%*s║\n" "$box_width" ""
    }

    banner_center_line() {
        local text="$1"
        local text_len=${#text}

        if [ "$text_len" -gt "$box_width" ]; then
            text="${text:0:$box_width}"
            text_len=${#text}
        fi

        local left_pad=$(( (box_width - text_len) / 2 ))
        local right_pad=$(( box_width - text_len - left_pad ))

        printf "║%*s%s%*s║\n" "$left_pad" "" "$text" "$right_pad" ""
    }

    local server_ip
    server_ip="$(hostname -I | awk '{print $1}')"

    local ram_info
    ram_info="$(free -h | awk '/Mem:/ {print $3 " / " $2}')"

    local disk_info
    disk_info="$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')"

    local load_info
    load_info="$(uptime | awk -F'load average: ' '{print $2}')"

    local temp_info
    temp_info="$(sensors 2>/dev/null | awk '/Package id 0|Core 0|temp1/ {print $2; exit}')"
    if [ -z "$temp_info" ]; then
        temp_info="N/A"
    fi

    local docker_status
    if systemctl is-active --quiet docker.service; then
        docker_status="${COLOR_GREEN}● Running${COLOR_RESET}"
    else
        docker_status="${COLOR_RED}● Stopped${COLOR_RESET}"
    fi

    echo -e "${COLOR_CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    banner_empty_line
    echo "║      ██╗      █████╗ ██████╗  ██████╗ ██████╗ ███████╗       ║"
    echo "║      ██║     ██╔══██╗██╔══██╗██╔═══██╗██╔══██╗██╔════╝       ║"
    echo "║      ██║     ███████║██████╔╝██║   ██║██████╔╝███████╗       ║"
    echo "║      ██║     ██╔══██║██╔══██╗██║   ██║██╔═══╝ ╚════██║       ║"
    echo "║      ███████╗██║  ██║██████╔╝╚██████╔╝██║     ███████║       ║"
    echo "║      ╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝     ╚══════╝       ║"
    banner_empty_line
    banner_center_line "DevOps Laboratory Platform"
    banner_center_line "Version $LABOPS_VERSION"
    banner_empty_line
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${COLOR_RESET}"

    echo -e "${COLOR_WHITE}Servidor:${COLOR_RESET} $(hostname)"
    echo -e "${COLOR_WHITE}Usuário..:${COLOR_RESET} $(whoami)"
    echo -e "${COLOR_WHITE}IP.......:${COLOR_RESET} ${server_ip}"
    echo -e "${COLOR_WHITE}Uptime...:${COLOR_RESET} $(uptime -p | sed 's/up //')"
    echo -e "${COLOR_WHITE}Data.....:${COLOR_RESET} $(date '+%d/%m/%Y %H:%M')"
    echo

    print_line
    echo -e "${COLOR_WHITE}RAM......:${COLOR_RESET} ${ram_info}"
    echo -e "${COLOR_WHITE}Disco....:${COLOR_RESET} ${disk_info}"
    echo -e "${COLOR_WHITE}Carga....:${COLOR_RESET} ${load_info}"
    echo -e "${COLOR_WHITE}Temp.....:${COLOR_RESET} ${temp_info}"
    echo -e "${COLOR_WHITE}Docker...:${COLOR_RESET} ${docker_status}"
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
