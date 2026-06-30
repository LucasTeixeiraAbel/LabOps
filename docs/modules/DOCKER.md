# Módulo Docker

## Identificação

- Módulo: Docker
- ID: docker
- Versão do módulo: 1.0.0
- Release LabOps: v1.1.0 - Docker

## Objetivo

Adicionar suporte ao Docker Engine e Docker Compose Plugin dentro do LabOps.

O módulo permite:

- instalar Docker;
- iniciar Docker;
- parar Docker;
- atualizar Docker;
- consultar status;
- executar teste `hello-world`.

## Estrutura

````text
modules/docker/
├── module.conf
├── install.sh
├── start.sh
├── stop.sh
├── status.sh
├── update.sh
└── menu.sh
```

##Dependências
Ubuntu Server
systemd
containerd
docker.socket
docker.service
Observação técnica

#Durante a instalação, foi identificado que o Docker dependia do docker.socket ativo para iniciar corretamente com fd://.

#Por isso, os scripts do módulo Docker foram ajustados para ativar:

containerd.service
docker.socket
docker.service
Comandos principais

#Instalar Docker:

/opt/labops/modules/docker/install.sh

#Ver status:

/opt/labops/modules/docker/status.sh

#Iniciar:

/opt/labops/modules/docker/start.sh

#Parar:

/opt/labops/modules/docker/stop.sh

#Atualizar:

/opt/labops/modules/docker/update.sh
#Teste realizado
sudo docker run hello-world

#Resultado esperado:

Hello from Docker!
Status

Aprovado.
