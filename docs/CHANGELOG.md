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
