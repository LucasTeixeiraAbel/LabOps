# LabOps

LabOps e uma plataforma modular de administracao de infraestrutura Linux criada para estudos praticos de DevOps, automacao, containers, monitoramento, bancos de dados, CI/CD e IA local.

## Missao

Construir uma plataforma de laboratorio que simule praticas reais de ambientes corporativos, tratando infraestrutura como produto de software.

## Slogan

Build. Automate. Learn.

## Versao atual

v1.5.0-dev - Container Monitoring

## Objetivos

- Aprender Linux na pratica.
- Construir uma CLI modular.
- Gerenciar servicos com Docker.
- Criar ambiente Web com Nginx.
- Subir bancos PostgreSQL.
- Implementar monitoramento com Prometheus, Grafana e Node Exporter.
- Criar base para deploy automatizado com GitHub Actions.
- Preparar ambiente para IA local com Ollama.
- Documentar toda a evolucao do projeto.

## Estrutura

    LabOps/
    ├── bin/
    ├── core/
    ├── modules/
    ├── compose/
    ├── config/
    ├── scripts/
    ├── assets/
    └── docs/

## Modulos ativos

- Docker
- Gateway / Nginx
- Banco de Dados / PostgreSQL
- Monitoramento / Observability

## Acessos principais

Em ambiente VirtualBox NAT com redirecionamento de portas:

    Gateway LabOps: http://localhost:8080
    Grafana:        http://localhost:3000
    Prometheus:     http://localhost:9091
    Node Exporter:  http://localhost:9100/metrics
    cAdvisor:      http://localhost:8081
    SSH:            ssh -p 2222 srvlucas@localhost

Dentro da VM:

    Gateway LabOps: http://localhost:8080
    Grafana:        http://localhost:3000
    Prometheus:     http://localhost:9091
    Node Exporter:  http://localhost:9100/metrics
    cAdvisor:      http://localhost:8081

## Docker

O Docker e a base para os servicos conteinerizados do LabOps.

O modulo Docker pode ser acessado pelo menu principal:

    [ 3 ] Docker

## Gateway / Nginx

O LabOps possui um Gateway Nginx rodando em container Docker.

Acesso local:

    http://localhost:8080

O modulo pode ser acessado pelo menu principal:

    [ 4 ] Gateway / Nginx

## PostgreSQL

O LabOps possui um modulo PostgreSQL rodando em container Docker.

Acesso local no servidor:

    Host: 127.0.0.1
    Porta: 5432
    Banco: labops
    Usuario: labops

O arquivo real de configuracao fica fora do Git:

    /opt/labops/config/postgres/postgres.env

Backups sao salvos em:

    /opt/labops/backups/postgres

O modulo pode ser acessado pelo menu principal:

    [ 7 ] Banco de Dados / PostgreSQL

Documentacao do modulo:

    docs/modules/POSTGRES.md

## Monitoramento / Observability

O LabOps possui um modulo inicial de monitoramento com:

- Prometheus
- Grafana
- Node Exporter

Servicos:

    labops-prometheus
    labops-grafana
    labops-node-exporter

Portas:

    Prometheus:    9091 no host, 9090 no container
    Grafana:       3000
    Node Exporter: 9100

A porta 9091 foi escolhida para o Prometheus no host para evitar conflito com o Cockpit, que pode usar a porta 9090.

O Grafana e provisionado automaticamente com:

    Data Source: LabOps Prometheus
    Dashboard: LabOps Overview

O arquivo real com credenciais do Grafana fica fora do Git:

    /opt/labops/config/grafana/grafana.env

O modulo pode ser acessado pelo menu principal:

    [ 8 ] Monitoramento

Pelo menu de Monitoramento e possivel:

- Ver status da stack.
- Instalar ou preparar o modulo.
- Iniciar os servicos.
- Parar os servicos.
- Atualizar imagens.
- Consultar login do Grafana.
- Resetar senha do Grafana.
- Ver URLs de acesso.

Documentacao do modulo:

    docs/modules/MONITOR.md


## Container Monitoring

A partir da versao v1.5.0-dev, o LabOps inclui monitoramento de containers com cAdvisor.

O cAdvisor coleta metricas dos containers Docker, como:

- Uso de CPU por container.
- Uso de memoria por container.
- Metricas de rede.
- Containers monitorados.
- Estado de coleta para o Prometheus.

Fluxo de monitoramento:

    Node Exporter  -> metricas da VM/servidor
    cAdvisor       -> metricas dos containers
    Prometheus     -> coleta e armazena as metricas
    Grafana        -> exibe dashboards

Acesso local:

    cAdvisor: http://localhost:8081

Dashboard no Grafana:

    Dashboards
    -> LabOps
    -> LabOps Containers

## Comando principal

Depois de instalado em /opt/labops, o LabOps pode ser iniciado com:

    labops

## Ambientes

Ambiente atual recomendado:

    VirtualBox NAT + Port Forwarding

Esse modo foi escolhido por ser mais estavel no ambiente atual do projeto.

Portas redirecionadas recomendadas:

    2222 -> 22
    8080 -> 8080
    3000 -> 3000
    9091 -> 9091
    9100 -> 9100

## Roadmap resumido

Concluido:

- Base modular do LabOps.
- Menu principal.
- Docker.
- Gateway / Nginx.
- PostgreSQL.
- Monitoramento inicial com Prometheus, Grafana e Node Exporter.

Em andamento:

- Evolucao dos dashboards.
- Documentacao da versao v1.4.0 concluida.
- Evolucao da release v1.5.0-dev - Container Monitoring em andamento.

Planejado:

- Monitoramento de containers.
- Alertas.
- Exporters adicionais.
- Backup em nuvem.
- IA local com Ollama.
- CI/CD com GitHub Actions.
