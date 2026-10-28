# Estágio 1: Extrai os binários oficiais
FROM prom/blackbox-exporter:latest as blackbox
FROM prom/prometheus:latest as prometheus

# Estágio Final: Base Grafana
FROM grafana/grafana:latest

USER root

# Copia os binários do Blackbox e Prometheus
COPY --from=blackbox /bin/blackbox_exporter /bin/blackbox_exporter
COPY --from=prometheus /bin/prometheus /bin/prometheus

# Copia as configurações
COPY blackbox.yml /etc/blackbox_exporter/config.yml
COPY prometheus.yml /etc/prometheus/prometheus.yml
COPY entrypoint.sh /entrypoint.sh

# Garante permissões de execução e pastas necessárias
RUN mkdir -p /prometheus /etc/blackbox_exporter /etc/prometheus && \
    chmod +x /entrypoint.sh && \
    chmod -R 777 /prometheus /etc/blackbox_exporter /etc/prometheus

USER grafana

EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]