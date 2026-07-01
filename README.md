# LabOps

**LabOps** é uma plataforma modular de administração de infraestrutura Linux criada para estudos práticos de DevOps, automação, containers, monitoramento, bancos de dados, CI/CD e IA local.

## Missão

Construir uma plataforma de laboratório que simule práticas reais de ambientes corporativos, tratando infraestrutura como produto de software.

## Slogan

**Build. Automate. Learn.**

## Versão atual

`v1.3.0 - Database`

## Objetivos

- Aprender Linux na prática
- Construir uma CLI modular
- Gerenciar serviços com Docker
- Criar ambiente Web com Nginx
- Subir bancos PostgreSQL e MySQL
- Implementar monitoramento com Grafana e Prometheus
- Criar deploy automatizado com GitHub Actions
- Rodar IA local com Ollama
- Documentar toda a evolução do projeto

## Estrutura

```text
LabOps/
├── bin/
├── core/
├── modules/
├── compose/
├── config/
├── scripts/
├── assets/
└── docs/

## Módulos ativos

- Docker
- Gateway / Nginx
- Banco de Dados / PostgreSQL

## PostgreSQL

O LabOps possui um módulo PostgreSQL rodando em container Docker.

Acesso local no servidor:

    Host: 127.0.0.1
    Porta: 5432
    Banco: labops
    Usuário: labops

O arquivo real de configuração fica fora do Git:

    /opt/labops/config/postgres/postgres.env

Backups são salvos em:

    /opt/labops/backups/postgres

O módulo pode ser acessado pelo menu principal:

    [ 7 ] Banco de Dados / PostgreSQL

