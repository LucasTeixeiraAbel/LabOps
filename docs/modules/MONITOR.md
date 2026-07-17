# LabOps - Modulo Monitoramento

## Visao geral

O modulo de Monitoramento adiciona uma stack inicial de observability ao LabOps usando:

- Prometheus
- Grafana
- Node Exporter

Esse modulo permite acompanhar metricas basicas da VM/servidor, visualizar dados em dashboard e validar a saude dos servicos principais.

---

## Servicos

| Servico | Container | Porta interna | Porta no host |
|---|---|---:|---:|
| Prometheus | labops-prometheus | 9090 | 9091 |
| Grafana | labops-grafana | 3000 | 3000 |
| Node Exporter | labops-node-exporter | 9100 | 9100 |

A porta 9090 foi evitada no host porque pode entrar em conflito com o Cockpit.

Por isso, o Prometheus usa:

    Host: 9091
    Container: 9090

---

## URLs de acesso

Em ambiente VirtualBox NAT com redirecionamento de portas:

    Gateway LabOps: http://localhost:8080
    Grafana:        http://localhost:3000
    Prometheus:     http://localhost:9091
    Node Exporter:  http://localhost:9100/metrics

Dentro da VM:

    Gateway LabOps: http://localhost:8080
    Grafana:        http://localhost:3000
    Prometheus:     http://localhost:9091
    Node Exporter:  http://localhost:9100/metrics

---

## Arquivos principais

    compose/monitor.yml
    modules/monitor/install.sh
    modules/monitor/start.sh
    modules/monitor/stop.sh
    modules/monitor/status.sh
    modules/monitor/update.sh
    modules/monitor/menu.sh
    config/prometheus/prometheus.yml
    config/grafana/grafana.env.example
    config/grafana/provisioning/datasources/prometheus.yml
    config/grafana/provisioning/dashboards/labops.yml
    config/grafana/dashboards/labops-overview.json

---

## Grafana

O Grafana e provisionado automaticamente com:

    Data Source: LabOps Prometheus
    Dashboard: LabOps Overview

O arquivo real com credenciais fica em:

    /opt/labops/config/grafana/grafana.env

Esse arquivo nao deve ser versionado no Git.

Para consultar o login pelo menu:

    labops
    -> [ 8 ] Monitoramento
    -> [ 6 ] Informacoes de login do Grafana

Para resetar a senha:

    labops
    -> [ 8 ] Monitoramento
    -> [ 7 ] Resetar senha do Grafana

---

## Comandos de operacao

Preparar o modulo:

    sudo /opt/labops/modules/monitor/install.sh

Iniciar:

    sudo /opt/labops/modules/monitor/start.sh

Ver status:

    sudo /opt/labops/modules/monitor/status.sh

Parar:

    sudo /opt/labops/modules/monitor/stop.sh

Atualizar imagens:

    sudo /opt/labops/modules/monitor/update.sh

---

## Testes de saude

Prometheus:

    curl http://localhost:9091/-/ready

Grafana:

    curl http://localhost:3000/api/health

Node Exporter:

    curl -s http://localhost:9100/metrics | sed -n '1,10p'

Resultado esperado:

    Prometheus: Running
    Grafana...: Running
    Node Exporter: Running

---

## Observacoes

- A rede Docker usada e labops-network.
- O Prometheus usa a porta 9091 no host para evitar conflito com Cockpit.
- O dashboard inicial e simples e serve como base para evolucoes futuras.
- O menu principal do LabOps ja possui integracao direta com o modulo Monitoramento.

---

## Container Monitoring

Na versao v1.5.0-dev, o modulo Monitoramento passou a incluir cAdvisor.

O cAdvisor e responsavel por coletar metricas dos containers Docker em execucao.

Servico:

    labops-cadvisor

Porta:

    Host: 8081
    Container: 8080

Acesso:

    http://localhost:8081
    http://localhost:8081/metrics

Prometheus scrape job:

    cadvisor -> labops-cadvisor:8080

Fluxo:

    cAdvisor coleta metricas dos containers.
    Prometheus coleta essas metricas.
    Grafana exibe o dashboard LabOps Containers.

Dashboard:

    Dashboards
    -> LabOps
    -> LabOps Containers

Metricas iniciais usadas:

    container_cpu_usage_seconds_total
    container_memory_usage_bytes
    container_network_receive_bytes_total
    container_last_seen
    up{job="cadvisor"}

Observacao:

O endpoint /metrics do cAdvisor mostra dados tecnicos em texto. Ele nao e uma tela visual para uso diario. A visualizacao principal deve ser feita pelo Grafana.

---

## Alertas Prometheus

Na versao v1.6.0, o modulo Monitoramento passou a incluir uma base inicial de alertas usando Prometheus Rules.

Arquivo de regras:

    config/prometheus/rules/labops-alerts.yml

Arquivo ativo na instalacao:

    /opt/labops/config/prometheus/rules/labops-alerts.yml

Interface Web:

    http://localhost:9091/alerts

Acesso pelo menu:

    labops
    -> [ 8 ] Monitoramento
    -> [ 9 ] Alertas do Prometheus

Validacao com promtool:

    docker exec labops-prometheus promtool check config /etc/prometheus/prometheus.yml
    docker exec labops-prometheus promtool check rules /etc/prometheus/rules/labops-alerts.yml

Regras iniciais:

    LabOpsTargetDown
    LabOpsHighCpuUsage
    LabOpsHighMemoryUsage
    LabOpsLowDiskSpace
    LabOpsContainerHighCpuUsage

Estados esperados:

    inactive = regra carregada e sem problema ativo
    pending  = condicao detectada, aguardando tempo do for
    firing   = alerta disparado

Observacao:

Nesta etapa, os alertas ficam visiveis no Prometheus e no menu do LabOps. Notificacoes externas ainda nao fazem parte do escopo.

