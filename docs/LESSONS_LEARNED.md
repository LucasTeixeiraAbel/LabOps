# LESSONS LEARNED

Aprendizados acumulados durante o desenvolvimento do LabOps.

---

## Sprint 001 - Foundation

### O que aprendemos

- Um servidor pode ser tratado como um produto de software.
- Separar instalação e código-fonte evita bagunça.
- O comando `labops` funciona como ponto de entrada do sistema.
- O Core Engine centraliza a inicialização.
- Logs ajudam a entender o comportamento do sistema.
- Documentação desde o início reduz retrabalho.

### Frase da Sprint

> Uma boa arquitetura nasce antes da primeira funcionalidade.

---

## Sprint v1.1.0 - Docker

### O que aprendemos

- Como criar um módulo no LabOps.
- Como organizar scripts de instalação, status, start, stop e update.
- Como integrar um módulo ao menu principal.
- Como testar o Docker com `hello-world`.
- Como diagnosticar falhas usando `systemctl` e `journalctl`.
- Como corrigir dependência entre `docker.service` e `docker.socket`.

### Frase da Sprint

> Instalar é apenas o começo. Validar, corrigir e documentar é o que torna a infraestrutura confiável.

---

## Sprint v1.1.1 - Docker Polish

### O que aprendemos

- Como listar containers Docker via script.
- Como listar imagens Docker via script.
- Como verificar uso de disco do Docker.
- Como criar uma rotina segura de limpeza.
- Como criar um diagnóstico básico para um serviço.
- Como melhorar um módulo sem quebrar sua estrutura.

### Frase da Sprint

> Um bom módulo não apenas instala. Ele opera, diagnostica e ajuda a manter o ambiente saudável.

--------------------------------------------------

---

## Lição - Conflito de Merge

Durante o merge da branch `develop` para a branch `main`, ocorreu um conflito no arquivo `README.md`.

### O que aconteceu

O Git identificou que o mesmo trecho do arquivo havia sido alterado em branches diferentes. Por isso, ele não conseguiu decidir automaticamente qual versão deveria ser mantida.

### Como identificamos

O Git informou:

```text
README.md: needs merge
error: you need to resolve your current index first ```

##Como resolvemos
Abrimos o arquivo em conflito.

Escolhemos a versão correta.
Removemos os marcadores do Git.
Salvamos o arquivo.
Marcamos como resolvido com git add.
Finalizamos com git commit.

##Aprendizado

Conflitos de merge são normais em projetos versionados. O importante é saber ler a mensagem do Git, localizar os marcadores de conflito, escolher a versão correta e concluir o merge com segurança.

##Frase da lição

Problemas em Git não são falhas do projeto. São oportunidades de entender melhor como o versionamento funciona.
----------------------

---

## Lição - Porta 80 interceptada pelo Traefik/Kubernetes

Durante a configuração do módulo Nginx Gateway, o LabOps respondia corretamente em `localhost`, mas retornava `404 page not found` ao acessar pelo IP da rede.

### O que aconteceu

O Nginx do LabOps estava funcionando corretamente, porém a porta `80` estava sendo interceptada por regras do Kubernetes/K3s e pelo Traefik.

A evidência apareceu nas regras de NAT:

```text
kube-system/traefik:web loadbalancer IP
-d 192.168.15.27/32 ... --dport 80````

Mesmo com o container labops-nginx parado, o IP do servidor continuava respondendo 404, provando que a resposta não vinha do Nginx do LabOps.

##Como resolvemos

Alteramos o mapeamento de porta do Gateway:

ports:
  - "8080:80"

Com isso, o LabOps passou a responder corretamente em:

http://192.168.15.27:8080

##Aprendizado

Nem todo erro HTTP vem da aplicação que estamos configurando. Em ambientes com Docker, Kubernetes, Traefik, iptables e múltiplas interfaces de rede, o tráfego pode ser interceptado antes de chegar ao serviço esperado.

##Frase da lição

O serviço pode estar certo, mas a rede pode estar levando a requisição para outro lugar.

---

## Sprint v1.3.0 - Database

### O que aprendemos

- Como criar um serviço PostgreSQL em container.
- Como usar Docker Compose para banco de dados.
- Como proteger senha real fora do Git.
- Como usar arquivo `.env` real no servidor.
- Como criar volume persistente para dados.
- Como gerar backup com `pg_dump`.
- Como restaurar backup com `psql`.
- Como validar banco com `pg_isready`.
- Como diferenciar container rodando de serviço pronto.
- Como corrigir permissões de volume em containers.
- Como lidar com container órfão após mudança de Compose Project.
- Como tratar rede Docker compartilhada entre módulos.
- Como integrar um módulo real ao menu principal do LabOps.
- Como centralizar a versão do projeto em um arquivo `VERSION`.

### Lição - Container running não significa serviço pronto

Durante os testes, o container PostgreSQL aparecia como ativo, mas ainda estava inicializando.

O status mostrava:

    health: starting

E em alguns momentos o teste retornava:

    rejecting connections

Aprendizado:

Um container pode estar rodando, mas a aplicação dentro dele ainda não estar pronta.

Para bancos de dados, é importante validar com ferramentas próprias do serviço, como:

    pg_isready

### Lição - Volume de banco precisa de permissão correta

O PostgreSQL apresentou erro ao acessar arquivos internos do volume:

    FATAL: could not open file "base/16384/2601": Permission denied

Aprendizado:

Volumes persistentes usados por containers precisam ter permissões compatíveis com o usuário interno do serviço.

No caso do PostgreSQL, o diretório de dados precisa pertencer ao usuário `postgres` dentro do container.

### Lição - Compose Project muda o controle dos containers

Ao mudar o nome do projeto Docker Compose, um container antigo ficou órfão.

Erro observado:

    container name "/labops-postgres" is already in use

Aprendizado:

O nome do projeto Compose faz parte do controle dos recursos criados.

Mudar o project name pode exigir limpeza ou migração de containers antigos.

### Lição - Rede Docker compartilhada precisa ser explícita

O PostgreSQL usou a rede:

    labops-network

Como essa rede já era usada por outros módulos, o Compose precisou tratá-la como externa.

Aprendizado:

Redes compartilhadas entre módulos devem ser planejadas como recursos globais da plataforma.

### Frase da sprint

> Banco de dados não se valida apenas vendo o container em pé. Ele se valida conectando, consultando e fazendo backup.
