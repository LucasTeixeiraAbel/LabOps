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
- [ ] Subir cAdvisor
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
