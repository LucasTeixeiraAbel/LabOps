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

Ao abrir o arquivo, os conflitos aparecem com marcadores como:

<<<<<<< HEAD
conteúdo da branch atual
=======
conteúdo da outra branch
>>>>>>> develop

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
