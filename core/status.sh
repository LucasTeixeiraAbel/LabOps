#!/bin/bash

load_system_status() {

    SERVER_HOSTNAME=$(hostname)
    SERVER_USER=$(whoami)
    SERVER_IP=$(hostname -I | awk '{print $1}')
    SERVER_UPTIME=$(uptime -p | sed 's/up //')
    SERVER_DATE=$(date '+%d/%m/%Y %H:%M')

    MEMORY_USAGE=$(free -h | awk '/Mem:/ {print $3 " / " $2}')
    DISK_USAGE=$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')
    LOAD_AVG=$(uptime | awk -F'load average:' '{print $2}' | sed 's/^ //')

    if command -v sensors >/dev/null 2>&1; then
        CPU_TEMP=$(sensors | awk '/Core 0|Package id 0|temp1/ {print $3; exit}')
        if [ -z "$CPU_TEMP" ]; then
            CPU_TEMP="N/A"
        fi
    else
        CPU_TEMP="N/A"
    fi

    if systemctl is-active --quiet docker; then
        DOCKER_STATUS="Running"
    else
        DOCKER_STATUS="Stopped"
    fi
}
