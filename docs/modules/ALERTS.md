# LabOps - Alertas

## Visao geral

O modulo de alertas do LabOps usa Prometheus Rules para detectar situacoes importantes no ambiente.

Na versao v1.6.0, os alertas aparecem no Prometheus e no menu do LabOps.

Interface principal:

    http://localhost:9091/alerts

Menu LabOps:

    labops
    -> [ 8 ] Monitoramento
    -> [ 9 ] Alertas do Prometheus

---

## Arquivos

Arquivo no repositorio:

    config/prometheus/rules/labops-alerts.yml

Arquivo ativo na instalacao:

    /opt/labops/config/prometheus/rules/labops-alerts.yml

Configuracao do Prometheus:

    config/prometheus/prometheus.yml

Compose:

    compose/monitor.yml

---

## Regras iniciais

### LabOpsTargetDown

Detecta quando um target do Prometheus fica indisponivel.

Condicao:

    up == 0

Tempo:

    1 minuto

Severidade:

    critical

---

### LabOpsHighCpuUsage

Detecta uso alto de CPU no servidor.

Condicao:

    CPU acima de 85%

Tempo:

    5 minutos

Severidade:

    warning

---

### LabOpsHighMemoryUsage

Detecta uso alto de memoria no servidor.

Condicao:

    Memoria acima de 85%

Tempo:

    5 minutos

Severidade:

    warning

---

### LabOpsLowDiskSpace

Detecta pouco espaco livre na particao raiz.

Condicao:

    Menos de 15% livre em /

Tempo:

    5 minutos

Severidade:

    warning

---

### LabOpsContainerHighCpuUsage

Detecta uso alto de CPU em containers.

Condicao:

    Container acima de 80% de CPU

Tempo:

    5 minutos

Severidade:

    warning

---

## Estados dos alertas

inactive:

    A regra esta carregada, mas nao ha problema ativo.

pending:

    A condicao foi detectada, mas ainda nao atingiu o tempo definido em for.

firing:

    O alerta foi disparado.

---

## Validacao

Validar configuracao do Prometheus:

    docker exec labops-prometheus promtool check config /etc/prometheus/prometheus.yml

Validar regras:

    docker exec labops-prometheus promtool check rules /etc/prometheus/rules/labops-alerts.yml

Consultar alertas pela API:

    curl -fsS http://localhost:9091/api/v1/alerts

Consultar regras pela API:

    curl -fsS http://localhost:9091/api/v1/rules

---

## Observacoes

- Esta versao nao envia notificacoes externas.
- Alertmanager esta reservado para uma versao futura.
- O objetivo inicial e criar a base de regras e integrar a visualizacao ao LabOps.
