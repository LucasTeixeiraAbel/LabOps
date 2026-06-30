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
