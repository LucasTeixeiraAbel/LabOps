# ENGINEERING LOG

Registro técnico das decisões, aprendizados e evolução do LabOps.

---

## 2026-06-29

### Decisão

Criar o LabOps como uma plataforma modular de administração de infraestrutura Linux.

### Motivo

Evitar que o projeto vire apenas um conjunto de scripts soltos. A arquitetura modular facilita manutenção, crescimento e documentação.

### Resultado

Foi criada a base inicial em `/opt/labops`, com estrutura organizada, comando `labops`, menu, logger, runtime e configuração.

### Aprendizado

Um projeto de infraestrutura bem feito deve ser planejado, versionado e documentado desde o início.

===================
---

## 2026-06-30

### Sprint

v1.1.0 - Docker

### Decisão

Criar o Docker como primeiro módulo real do LabOps.

### Motivo

O Docker será a base para os próximos serviços do projeto, como Nginx, PostgreSQL, Grafana, Portainer e Ollama.

### Problema encontrado

Durante a inicialização do Docker, o serviço falhou porque dependia do `docker.socket` ativo.

### Solução

Os scripts do módulo Docker foram ajustados para inicializar corretamente:

- `containerd.service`
- `docker.socket`
- `docker.service`

### Resultado

Docker instalado, iniciado e validado com sucesso usando o teste `hello-world`.

### Aprendizado

Serviços Linux podem depender de sockets do systemd. Ao automatizar infraestrutura, não basta instalar pacotes; é necessário validar como os serviços são inicializados.

---------------------------------------------------------

---

## 2026-06-30

### Sprint

v1.1.1 - Docker Polish

### Decisão

Aprimorar o módulo Docker antes de avançar para os próximos serviços.

### Motivo

Como Docker será a base para Nginx, PostgreSQL, Grafana, Portainer e Ollama, foi decidido fortalecer primeiro o gerenciamento básico de containers, imagens, disco e diagnóstico.

### Resultado

O módulo Docker passou a oferecer:

- Listagem de containers
- Listagem de imagens
- Consulta de uso de disco
- Diagnóstico com Docker Doctor
- Limpeza segura
- Menu expandido

### Aprendizado

Antes de construir novos serviços sobre uma base, é importante garantir que a base tenha ferramentas de diagnóstico, manutenção e operação.
