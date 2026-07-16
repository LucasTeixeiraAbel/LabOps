# ROADMAP

## LabOps v1.0.0 - Foundation

### Objetivo

Criar a fundação do LabOps: estrutura, CLI, Core Engine, menu, logs, runtime e documentação inicial.

### Tarefas

- [x] Instalar Ubuntu Server
- [x] Configurar acesso SSH
- [x] Criar estrutura `/opt/labops`
- [x] Criar comando global `labops`
- [x] Criar menu inicial
- [x] Melhorar identidade visual da CLI
- [x] Criar logger
- [x] Criar runtime
- [x] Criar carregamento de configuração
- [ ] Criar repositório Git local
- [ ] Criar documentação inicial
- [ ] Criar sistema de módulos
- [ ] Criar tela de status avançado
- [ ] Preparar publicação no GitHub

---

## LabOps v1.1.0 - Docker

- [x] Instalar Docker
- [x] Instalar Docker Compose
- [x] Criar módulo Docker
- [x] Criar opção Docker no menu
- [ ] Criar Portainer
- [x] Documentar módulo Docker

---

## LabOps v1.1.1 - Docker Polish

- [x] Listar containers Docker
- [x] Listar imagens Docker
- [x] Ver uso de disco Docker
- [x] Criar Docker Doctor
- [x] Criar limpeza segura
- [x] Expandir menu Docker
- [x] Validar funções pelo menu LabOps

---

## LabOps v1.2.0 - Gateway

- [x] Criar módulo Nginx
- [x] Criar Docker Compose do Gateway
- [x] Criar página inicial web
- [x] Criar configuração Nginx
- [x] Rodar Gateway em container
- [x] Resolver conflito com Traefik/Kubernetes
- [x] Alterar porta externa para 8080
- [x] Integrar Gateway ao menu principal
- [x] Criar menu de logs e diagnóstico
- [x] Validar acesso pelo navegador
- [x] Documentar módulo Nginx

---

## LabOps v1.3.0 - Database

- [ ] Subir PostgreSQL
- [ ] Subir MySQL
- [ ] Subir Adminer
- [ ] Criar backup de bancos

---

## LabOps v1.4.0 - Observatory

- [ ] Subir Grafana
- [ ] Subir Prometheus
- [ ] Subir Node Exporter
- [x] Subir cAdvisor
- [ ] Criar dashboards

---

## LabOps v1.5.0 - Intelligence

- [ ] Instalar Ollama
- [ ] Rodar IA local
- [ ] Criar interface para IA
- [ ] Documentar limitações de hardware

---

## LabOps v2.0.0 - Enterprise

- [ ] Criar dashboard web
- [ ] Criar painel de administração
- [ ] Criar LabOps Doctor
- [ ] Criar LabOps Audit
- [ ] Exportar relatórios

## LabOps v1.3.0 - Database

- [x] Criar módulo PostgreSQL
- [x] Criar Docker Compose do PostgreSQL
- [x] Criar arquivo exemplo `postgres.env.example`
- [x] Manter senha real fora do Git
- [x] Criar scripts install/start/stop/status/update
- [x] Criar backup do PostgreSQL
- [x] Criar restore do PostgreSQL
- [x] Corrigir permissões do volume de dados
- [x] Corrigir conflito de Compose Project
- [x] Configurar rede compartilhada `labops-network`
- [x] Integrar PostgreSQL ao menu principal
- [x] Testar conexão SQL pelo menu
- [x] Validar healthcheck
- [x] Validar backup
- [x] Centralizar versão no arquivo VERSION
- [x] Corrigir banner dinâmico
- [x] Documentar módulo PostgreSQL

## v1.4.0 - Observability

Status: concluido.

Objetivo principal:

Adicionar uma camada inicial de observability ao LabOps, permitindo acompanhar metricas do servidor, visualizar dados no Grafana e criar uma base para monitoramento mais avancado.

Escopo inicial:

- Prometheus para coleta de metricas.
- Grafana para visualizacao.
- Node Exporter para metricas do sistema operacional.
- Dashboard inicial LabOps Overview.
- Provisionamento automatico do Grafana.
- Data source Prometheus configurado automaticamente.
- Integracao do modulo Monitoramento ao menu principal.
- Opcoes de login e reset de senha do Grafana pelo menu.

Servicos previstos:

- labops-prometheus
- labops-grafana
- labops-node-exporter

Portas utilizadas:

- Gateway LabOps: 8080
- Grafana: 3000
- Prometheus: 9091
- Node Exporter: 9100

Observacao:

A porta 9090 foi evitada no host por possivel conflito com Cockpit. O Prometheus usa 9091 no host e 9090 dentro do container.

Proximas melhorias possiveis:

- Dashboard mais completo para CPU, memoria, disco e rede.
- Monitoramento dos containers Docker.
- Alertas no Prometheus Alertmanager.
- Exporter para PostgreSQL.
- Exporter para Nginx.
- Documentacao de troubleshooting do monitoramento.
- Preparacao para backup em nuvem em sprint futura.

## v1.5.0 - Container Monitoring

Status: concluido.

Objetivo principal:

Expandir a observability do LabOps para monitorar containers Docker individualmente, usando cAdvisor como fonte de metricas para o Prometheus e dashboards dedicados no Grafana.

Escopo inicial:

- Adicionar cAdvisor na stack de monitoramento.
- Expor cAdvisor na porta 8081.
- Configurar Prometheus para coletar metricas do cAdvisor.
- Integrar cAdvisor ao menu e status do modulo Monitoramento.
- Criar dashboard LabOps Containers no Grafana.
- Documentar o fluxo de metricas de containers.

Servicos envolvidos:

- labops-cadvisor
- labops-prometheus
- labops-grafana
- labops-node-exporter

Portas utilizadas:

- cAdvisor: 8081
- Prometheus: 9091
- Grafana: 3000
- Node Exporter: 9100

Proximas melhorias possiveis:

- Painel mais detalhado por container.
- Alertas para container parado.
- Alertas de consumo alto de CPU e memoria.
- Integracao do status real dos containers no portal Web.
- Exporter dedicado para PostgreSQL.
- Exporter dedicado para Nginx.

## v1.6.0 - Alerts

Status: em desenvolvimento.

Objetivo principal:

Adicionar uma base inicial de alertas ao LabOps usando Prometheus Rules, permitindo identificar problemas de disponibilidade, CPU, memoria, disco e containers diretamente pela interface do Prometheus e pelo menu do LabOps.

Escopo inicial:

- Criar arquivo de regras em config/prometheus/rules/labops-alerts.yml.
- Montar a pasta de regras no container Prometheus.
- Ativar rule_files no prometheus.yml.
- Validar regras com promtool.
- Exibir alertas em http://localhost:9091/alerts.
- Integrar consulta de alertas no status do modulo Monitoramento.
- Adicionar opcao Alertas do Prometheus no menu do modulo Monitoramento.
- Documentar funcionamento e validacao dos alertas.

Regras previstas:

- Target indisponivel.
- CPU alta no servidor.
- Memoria alta no servidor.
- Pouco espaco em disco.
- CPU alta em container.

Fora do escopo inicial:

- Envio de notificacoes externas.
- Alertmanager.
- Integracao com e-mail, Telegram ou Discord.
- Silenciamento avancado de alertas.
- Rotas de notificacao por severidade.

Proximas melhorias possiveis:

- Adicionar Alertmanager.
- Criar dashboard de alertas no Grafana.
- Criar alertas para PostgreSQL.
- Criar alertas para Nginx.
- Criar alertas para containers parados.
- Exibir resumo de alertas no portal Web.

