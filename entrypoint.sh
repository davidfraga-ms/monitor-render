#!/bin/sh

# Inicia o Blackbox Exporter na porta 9115
/bin/blackbox_exporter --config.file=/etc/blackbox_exporter/config.yml &

# Inicia o Prometheus na porta 9090
/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/prometheus &

# Inicia o Grafana na porta 3000 em primeiro plano
exec /run.sh