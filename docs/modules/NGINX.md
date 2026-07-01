# LabOps Module - Nginx Gateway

## Identificação

- Módulo: Nginx Gateway
- Versão: v1.2.0
- Status: Ativo
- Porta externa: 8080
- Porta interna do container: 80
- Container: labops-nginx
- Imagem: nginx:alpine

## Objetivo

O módulo Nginx Gateway fornece a primeira interface web do LabOps.

Ele é responsável por servir a página inicial da plataforma e preparar a base para futuros reverse proxies, como:

- grafana.srv.lab
- portainer.srv.lab
- app.srv.lab
- ia.srv.lab

## Arquivos principais

```text
modules/nginx/
├── module.conf
├── install.sh
├── start.sh
├── stop.sh
├── status.sh
├── update.sh
└── menu.sh
compose/
└── nginx.yml
config/nginx/conf.d/
└── default.conf
www/
├── index.html
└── assets/
````
## Docker Compose

O Gateway roda via Docker Compose usando a imagem oficial nginx:alpine.

A porta externa usada pelo LabOps é 8080, mapeada para a porta interna 80 do container.

ports:
  - "8080:80"
Motivo da porta 8080

Durante os testes, foi identificado que a porta 80 já estava sendo interceptada pelo Kubernetes/K3s e Traefik.

A evidência apareceu nas regras NAT do servidor, indicando que o Traefik estava usando o IP do servidor na porta 80.

Por isso, o LabOps Gateway foi configurado para responder em:

http://IP_DO_SERVIDOR:8080

Exemplo:

http://192.168.15.27:8080
Comandos principais

Preparar o Nginx:

/opt/labops/modules/nginx/install.sh

Iniciar o Gateway:

/opt/labops/modules/nginx/start.sh

Parar o Gateway:

/opt/labops/modules/nginx/stop.sh

Ver status:

/opt/labops/modules/nginx/status.sh

Atualizar imagem/container:

/opt/labops/modules/nginx/update.sh
Testes

Teste local:

curl -I http://localhost:8080/

Teste pelo IP do servidor:

curl -I http://192.168.15.27:8080/

Resultado esperado:

HTTP/1.1 200 OK
Server: nginx
Menu LabOps

O módulo Nginx foi integrado ao menu principal do LabOps:

[ 4 ] Gateway / Nginx

O menu do módulo permite:

- Consultar status
- Preparar o Nginx
- Iniciar Gateway
- Parar Gateway
- Atualizar Gateway
- Testar localhost
- Testar IP do servidor
- Mostrar logs
- Lições técnicas

Durante a implementação, foi aprendido que nem todo erro HTTP vem da aplicação configurada.

Mesmo com o Nginx correto, a porta 80 estava sendo interceptada antes de chegar ao container do LabOps.

A solução aplicada foi alterar o Gateway para a porta 8080.

# Status final

O módulo Nginx Gateway foi validado com sucesso.

- O LabOps possui agora:

Docker funcional
Gateway web funcional
Página inicial do LabOps
Menu CLI integrado
Diagnóstico de portas no menu principal

