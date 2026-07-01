#!/bin/bash

postgres_menu() {

    while true; do

        clear
        show_banner

        print_header "POSTGRESQL DATABASE MODULE"

        echo -e "${COLOR_GREEN}[ 1 ]${COLOR_RESET} Status do PostgreSQL"
        echo -e "${COLOR_GREEN}[ 2 ]${COLOR_RESET} Preparar PostgreSQL"
        echo -e "${COLOR_GREEN}[ 3 ]${COLOR_RESET} Iniciar PostgreSQL"
        echo -e "${COLOR_YELLOW}[ 4 ]${COLOR_RESET} Parar PostgreSQL"
        echo -e "${COLOR_YELLOW}[ 5 ]${COLOR_RESET} Atualizar PostgreSQL"
        echo
        echo -e "${COLOR_BLUE}[ 6 ]${COLOR_RESET} Gerar backup"
        echo -e "${COLOR_BLUE}[ 7 ]${COLOR_RESET} Restaurar backup"
        echo -e "${COLOR_BLUE}[ 8 ]${COLOR_RESET} Testar conexão"
        echo -e "${COLOR_BLUE}[ 9 ]${COLOR_RESET} Listar backups"
        echo -e "${COLOR_BLUE}[10 ]${COLOR_RESET} Mostrar logs"
        echo
        echo -e "${COLOR_RED}[ 0 ]${COLOR_RESET} Voltar"
        echo

        print_line

        read -p "Escolha uma opção: " postgres_option

        echo

        case "$postgres_option" in
            1)
                log_info "Consultando status do PostgreSQL."
                "$LABOPS_HOME/modules/postgres/status.sh"
                pause_screen
                ;;
            2)
                log_info "Preparando PostgreSQL."
                "$LABOPS_HOME/modules/postgres/install.sh"
                pause_screen
                ;;
            3)
                log_info "Iniciando PostgreSQL."
                "$LABOPS_HOME/modules/postgres/start.sh"
                pause_screen
                ;;
            4)
                log_warn "Parando PostgreSQL."
                "$LABOPS_HOME/modules/postgres/stop.sh"
                pause_screen
                ;;
            5)
                log_info "Atualizando PostgreSQL."
                "$LABOPS_HOME/modules/postgres/update.sh"
                pause_screen
                ;;
            6)
                log_info "Gerando backup do PostgreSQL."
                "$LABOPS_HOME/modules/postgres/backup.sh"
                pause_screen
                ;;
            7)
                log_warn "Iniciando restore do PostgreSQL."
                "$LABOPS_HOME/modules/postgres/restore.sh"
                pause_screen
                ;;
            8)
                log_info "Testando conexão com PostgreSQL."
                if sudo docker ps --format '{{.Names}}' | grep -q '^labops-postgres$'; then
                    sudo docker exec labops-postgres sh -c 'psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "SELECT current_database(), current_user, now();"'
                else
                    echo "PostgreSQL não está rodando."
                fi
                pause_screen
                ;;
            9)
                log_info "Listando backups do PostgreSQL."
                ls -lh /opt/labops/backups/postgres 2>/dev/null || echo "Nenhum backup encontrado."
                pause_screen
                ;;
            10)
                log_info "Exibindo logs do PostgreSQL."
                sudo docker logs labops-postgres --tail 100 2>/dev/null || echo "Container labops-postgres não encontrado."
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
