# CHANGELOG

Todas as mudanças importantes do LabOps serão documentadas neste arquivo.

O projeto segue versionamento semântico:

- MAJOR: mudanças grandes
- MINOR: novas funcionalidades
- PATCH: correções
----------------------------------------------

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

---

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
