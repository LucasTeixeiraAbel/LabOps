# LabOps Module - PostgreSQL Database

## Identificação

- Módulo: PostgreSQL Database
- Versão: v1.3.0
- Status: Ativo
- Container: labops-postgres
- Imagem: postgres:16-alpine
- Porta interna: 5432
- Porta externa: 127.0.0.1:5432
- Rede Docker: labops-network
- Banco padrão: labops
- Usuário padrão: labops

## Objetivo

O módulo PostgreSQL fornece o primeiro serviço de banco de dados do LabOps.

Ele prepara a base para futuros serviços, aplicações, dashboards, automações e integrações que precisem de persistência de dados.

O PostgreSQL roda em container Docker, usando volume persistente em disco e arquivo de configuração seguro fora do repositório Git.

## Arquivos principais

Estrutura do módulo:

    modules/postgres/
    ├── module.conf
    ├── install.sh
    ├── start.sh
    ├── stop.sh
    ├── status.sh
    ├── update.sh
    ├── backup.sh
    ├── restore.sh
    └── menu.sh

Docker Compose:

    compose/
    └── postgres.yml

Configuração exemplo:

    config/postgres/
    └── postgres.env.example

Configuração real no servidor:

    /opt/labops/config/postgres/postgres.env

Dados persistentes:

    /opt/labops/data/postgres

Backups:

    /opt/labops/backups/postgres

## Segurança da configuração

O arquivo real de configuração do PostgreSQL não é enviado ao GitHub.

Arquivo versionado:

    config/postgres/postgres.env.example

Arquivo real no servidor:

    /opt/labops/config/postgres/postgres.env

O arquivo real contém:

    POSTGRES_DB=labops
    POSTGRES_USER=labops
    POSTGRES_PASSWORD=<senha_gerada_automaticamente>

A senha é criada automaticamente durante a preparação do módulo.

## Docker Compose

O PostgreSQL é executado via Docker Compose usando a imagem:

    postgres:16-alpine

A porta foi configurada assim:

    127.0.0.1:5432:5432

Isso significa que o banco fica acessível somente localmente no servidor, reduzindo exposição na rede.

## Rede Docker

O módulo usa a rede compartilhada:

    labops-network

Essa rede é usada para comunicação entre os serviços do LabOps.

A rede é tratada como externa no Compose do PostgreSQL para evitar conflitos com outros módulos, como Nginx Gateway.

## Comandos principais

Preparar PostgreSQL:

    /opt/labops/modules/postgres/install.sh

Iniciar PostgreSQL:

    /opt/labops/modules/postgres/start.sh

Parar PostgreSQL:

    /opt/labops/modules/postgres/stop.sh

Ver status:

    /opt/labops/modules/postgres/status.sh

Atualizar imagem/container:

    /opt/labops/modules/postgres/update.sh

Gerar backup:

    /opt/labops/modules/postgres/backup.sh

Restaurar backup:

    /opt/labops/modules/postgres/restore.sh

## Testes realizados

Status do container:

    /opt/labops/modules/postgres/status.sh

Resultado esperado:

    PostgreSQL: Running
    Healthcheck: healthy
    pg_isready: accepting connections

Teste de conexão SQL:

    sudo docker exec labops-postgres sh -c 'psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "SELECT current_database(), current_user, now();"'

Resultado esperado:

    current_database | current_user | now
    labops           | labops       | ...

## Backup

O módulo possui rotina de backup usando pg_dump.

Os arquivos são gerados em:

    /opt/labops/backups/postgres

Formato do arquivo:

    labops-postgres-YYYY-MM-DD-HHMMSS.sql.gz

O backup é compactado com gzip e protegido com permissão restrita.

## Restore

O restore pode ser executado pelo script:

    /opt/labops/modules/postgres/restore.sh

O script lista os backups disponíveis e solicita confirmação antes de restaurar.

## Menu LabOps

O módulo PostgreSQL foi integrado ao menu principal do LabOps:

    [ 7 ] Banco de Dados / PostgreSQL

O submenu permite:

- Consultar status do PostgreSQL
- Preparar PostgreSQL
- Iniciar PostgreSQL
- Parar PostgreSQL
- Atualizar PostgreSQL
- Gerar backup
- Restaurar backup
- Testar conexão
- Listar backups
- Mostrar logs

## Problemas encontrados

### Permissão no volume de dados

Durante os testes, o PostgreSQL apresentou erro de permissão ao acessar arquivos dentro do volume de dados.

Erro observado:

    FATAL: could not open file "base/16384/2601": Permission denied

A correção foi ajustar o dono do diretório de dados para o usuário PostgreSQL usado dentro do container.

### Healthcheck em estado starting

Após iniciar o container, o PostgreSQL podia aparecer como:

    health: starting

Mesmo já aceitando conexões.

A solução foi melhorar o start.sh para aguardar o banco responder ao pg_isready antes de finalizar a inicialização.

### Conflito de Compose Project

Após padronizar o nome do projeto Compose, um container antigo ficou órfão com o mesmo nome.

Erro observado:

    container name "/labops-postgres" is already in use

A solução foi detectar containers antigos e removê-los preservando os dados em:

    /opt/labops/data/postgres

### Rede compartilhada

O Docker Compose alertou que a rede labops-network já existia, mas não tinha sido criada pelo projeto PostgreSQL.

A solução foi tratar a rede como externa:

    external: true

## Status final

O módulo PostgreSQL foi validado com sucesso.

Validações aprovadas:

- Container rodando
- Healthcheck saudável
- pg_isready aceitando conexões
- Consulta SQL funcionando
- Backup funcionando
- Menu LabOps funcionando
- Logs acessíveis pelo menu
- Rede compartilhada corrigida
- Volume persistente funcionando

## Conclusão

A sprint v1.3.0 adicionou ao LabOps seu primeiro módulo de banco de dados.

O projeto passa a contar com:

- Docker
- Nginx Gateway
- PostgreSQL Database
- Backup e restore
- Menu CLI integrado
- Versionamento centralizado
- Banner dinâmico
