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

-----------------------

---

## 2026-06-30

### Sprint

v1.2.0 - Gateway

### Decisão

Criar o primeiro Gateway web do LabOps usando Nginx em container Docker.

### Motivo

O LabOps precisava de uma interface web inicial e de uma base para futuros serviços acessíveis por subdomínios locais.

### Implementação

Foi criado um módulo Nginx com scripts de instalação, inicialização, parada, atualização, status e menu próprio.

Também foi criada uma página inicial em `www/index.html`, servida pelo container `labops-nginx`.

### Problema encontrado

Durante os testes, o acesso via `localhost` funcionava, mas o acesso pelo IP do servidor retornava `404 page not found`.

### Diagnóstico

Foi identificado que a porta `80` estava sendo interceptada por regras do Kubernetes/K3s e Traefik.

Mesmo com o container Nginx parado, a porta 80 continuava respondendo, provando que o tráfego não estava chegando ao Gateway do LabOps.

### Solução

O mapeamento externo do Gateway foi alterado para a porta `8080`.

```yaml
ports:
  - "8080:80"
```

##Resultado

O Gateway passou a funcionar corretamente em:

http://192.168.15.27:8080

##Aprendizado

Em ambientes com Docker, Kubernetes, Traefik, CNI e iptables, o tráfego pode ser interceptado antes de chegar ao serviço esperado.

A aplicação pode estar correta, mas a rede pode estar desviando a requisição.

------------------------------------------------------------

---

## 2026-07-01

### Sprint

v1.3.0 - Database

### Decisão

Adicionar o PostgreSQL como primeiro módulo de banco de dados do LabOps.

### Motivo

O LabOps precisava de uma camada de persistência para suportar futuros serviços, aplicações, dashboards e automações.

O PostgreSQL foi escolhido por ser robusto, amplamente utilizado em ambientes profissionais e adequado para estudos de infraestrutura, DevOps e backend.

### Implementação

Foi criado o módulo `modules/postgres`, contendo scripts para:

- instalação/preparação
- inicialização
- parada
- status
- atualização
- backup
- restore
- menu interativo

Também foi criado o arquivo `compose/postgres.yml`, usando a imagem `postgres:16-alpine`.

### Segurança

A senha real do banco não foi versionada.

Foi criado apenas o arquivo de exemplo:

    config/postgres/postgres.env.example

A configuração real fica em:

    /opt/labops/config/postgres/postgres.env

### Problema: permissão no volume

Durante os testes, o PostgreSQL apresentou erro ao acessar arquivos internos do banco:

    FATAL: could not open file "base/16384/2601": Permission denied

A causa foi permissão incorreta no volume persistente:

    /opt/labops/data/postgres

A solução foi ajustar o dono do diretório para o usuário PostgreSQL do container.

### Problema: banco rodando, mas ainda não pronto

Foi observado que o container podia estar `Up`, mas o banco ainda não estava pronto para conexão.

A solução foi melhorar o `start.sh` para aguardar `pg_isready` responder antes de finalizar.

### Problema: conflito de container

Após padronizar o nome do Compose Project, um container antigo ficou órfão com o mesmo nome:

    labops-postgres

A solução foi detectar e remover containers antigos preservando os dados no volume persistente.

### Problema: rede Docker compartilhada

O Docker Compose alertou que a rede `labops-network` já existia, mas não pertencia ao projeto PostgreSQL.

A solução foi declarar a rede como externa no Compose.

### Melhoria de core

Durante a sprint, foi identificado que a versão exibida no banner ainda estava fixa como `1.0 - Foundation`.

Foi criado o arquivo central:

    VERSION

A partir dele, o LabOps passou a exibir dinamicamente a versão atual.

### Resultado

O módulo PostgreSQL foi validado com sucesso.

O LabOps agora possui:

- Docker
- Gateway Nginx
- PostgreSQL
- Backup e restore
- Menu CLI integrado
- Versionamento centralizado
- Banner dinâmico

### Aprendizado

Container `running` não significa serviço pronto.

Para banco de dados, é necessário validar:

- container rodando
- healthcheck saudável
- pg_isready aceitando conexões
- consulta SQL funcionando
- backup testado
