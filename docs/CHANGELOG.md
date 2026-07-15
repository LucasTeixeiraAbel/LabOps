# Changelog

## v1.5.0-dev - Container Monitoring

### Adicionado

- cAdvisor para coleta de metricas dos containers Docker.
- Scrape job cadvisor no Prometheus.
- Porta 8081 para acesso ao cAdvisor.
- Integracao do cAdvisor ao status do modulo Monitoramento.
- Link do cAdvisor no menu de URLs do modulo Monitoramento.
- Dashboard LabOps Containers no Grafana.
- Paineis iniciais para CPU, memoria, rede e quantidade de containers monitorados.

### Alterado

- Stack de monitoramento expandida para incluir metricas de containers.
- VERSION atualizado para v1.5.0-dev - Container Monitoring.

### Validado

- Container labops-cadvisor rodando.
- Endpoint http://localhost:8081/metrics respondendo.
- Prometheus coletando o job cadvisor.
- Grafana estavel apos ajuste do datasource.
- Dashboard LabOps Containers carregando no Grafana.


## v1.4.0 - Observability

### Adicionado

- Modulo inicial de Monitoramento.
- Stack com Prometheus, Grafana e Node Exporter.
- Arquivo compose dedicado em compose/monitor.yml.
- Configuracao inicial do Prometheus em config/prometheus/prometheus.yml.
- Provisionamento automatico do Grafana com data source Prometheus.
- Dashboard inicial LabOps Overview.
- Integracao do modulo Monitoramento ao menu principal do LabOps.
- Menu do modulo Monitoramento com opcoes de status, instalar, iniciar, parar e atualizar.
- Opcao para visualizar informacoes de login do Grafana.
- Opcao para resetar senha do Grafana pelo menu.

### Alterado

- Prometheus passou a usar a porta 9091 no host.
- A porta 9090 foi evitada para nao conflitar com Cockpit.
- Menu principal passou a tratar Monitoramento como modulo ativo.
- Portal Web do LabOps atualizado para v1.4.0 - Observability.

### Validado

- Prometheus respondendo em http://localhost:9091.
- Grafana respondendo em http://localhost:3000.
- Node Exporter respondendo em http://localhost:9100/metrics.
- PostgreSQL permanece healthy.
- Nginx Gateway permanece ativo em http://localhost:8080.


## [1.3.0] - Database

### Adicionado

- Módulo PostgreSQL Database.
- Docker Compose para PostgreSQL.
- Arquivo exemplo de configuração `postgres.env.example`.
- Configuração real segura fora do Git.
- Volume persistente em `/opt/labops/data/postgres`.
- Diretório de backups em `/opt/labops/backups/postgres`.
- Scripts de instalação, start, stop, status e update.
- Scripts de backup e restore.
- Menu próprio do módulo PostgreSQL.
- Integração com o menu principal do LabOps.
- Teste de conexão SQL pelo menu.
- Listagem de backups pelo menu.
- Exibição de logs do PostgreSQL pelo menu.

### Melhorado

- Menu principal agora possui módulo ativo de Banco de Dados / PostgreSQL.
- Versão do LabOps centralizada no arquivo `VERSION`.
- Banner do LabOps passou a usar versão dinâmica.
- Textos do banner foram centralizados automaticamente.
- Start do PostgreSQL agora aguarda o banco ficar pronto antes de finalizar.

### Corrigido

- Correção de permissões no volume de dados do PostgreSQL.
- Correção de conflito de container órfão após mudança de Compose Project.
- Correção da rede compartilhada `labops-network` como rede externa.
- Padronização de backups com grupo `labops`.
- Correção da versão antiga exibida no banner.

### Validado

- PostgreSQL rodando via Docker.
- Healthcheck retornando `healthy`.
- `pg_isready` aceitando conexões.
- Consulta SQL executada com sucesso.
- Backup `.sql.gz` gerado com sucesso.
- Menu PostgreSQL funcionando dentro do LabOps.
- Banner exibindo `v1.3.0 - Database`.


# CHANGELOG

Todas as mudanças importantes do LabOps serão documentadas neste arquivo.

O projeto segue versionamento semântico:

- MAJOR: mudanças grandes
- MINOR: novas funcionalidades
- PATCH: correções
----------------------------------------------

## [1.2.0] - Gateway

### Adicionado

- Módulo Nginx Gateway.
- Docker Compose para execução do Nginx.
- Página inicial web do LabOps.
- Configuração Nginx em `config/nginx/conf.d/default.conf`.
- Menu específico do módulo Gateway / Nginx.
- Integração do Gateway ao menu principal.
- Inicialização rápida no menu principal.
- Área de logs e diagnóstico no menu principal.
- Diagnóstico de portas 80 e 8080.

### Melhorado

- Menu principal expandido.
- Separação entre módulos ativos e módulos futuros.
- Acesso web inicial ao LabOps.
- Diagnóstico operacional do ambiente.

### Corrigido

- Alteração da porta externa do Gateway de `80` para `8080` para evitar conflito com Traefik/Kubernetes.

### Validado

- Nginx rodando via Docker.
- Página inicial acessível em `http://IP_DO_SERVIDOR:8080`.
- Menu Gateway funcionando.
- Logs do Nginx acessíveis pelo menu.
- Testes `curl` com retorno `HTTP/1.1 200 OK`.

------------------------------------
## [1.1.1] - Docker Polish

### Adicionado

- Listagem de containers Docker.
- Listagem de imagens Docker.
- Consulta de uso de disco do Docker.
- Docker Doctor para diagnóstico básico.
- Limpeza segura de containers parados, imagens não utilizadas e cache de build.
- Menu Docker expandido.

### Melhorado

- Módulo Docker agora possui recursos básicos de administração.
- Menu Docker ficou mais completo e preparado para próximos serviços.

### Validado

- Status do Docker funcionando.
- Listagem de containers funcionando.
- Listagem de imagens funcionando.
- Uso de disco Docker funcionando.
- Docker Doctor funcionando.
- Teste hello-world executado com sucesso.

-------------------
## [1.1.0] - Docker

### Adicionado

- Módulo Docker.
- Scripts `install.sh`, `start.sh`, `stop.sh`, `status.sh` e `update.sh`.
- Submenu Docker dentro da CLI do LabOps.
- Teste `hello-world` pelo menu.
- Integração do Docker com o Core visual do LabOps.

### Corrigido

- Inicialização do Docker usando `docker.socket`.
- Funções auxiliares de interface `print_header` e `pause_screen`.

### Validado

- Docker Engine funcionando.
- Docker Compose Plugin funcionando.
- `sudo docker run hello-world` executado com sucesso.

------------

## [1.0.0] - Foundation

### Adicionado

- Estrutura inicial do projeto
- Diretório `/opt/labops`
- Comando global `labops`
- Core inicial
- Menu interativo
- Identidade visual da CLI
- Logger
- Runtime
- Arquivo de configuração
- Documentação inicial
