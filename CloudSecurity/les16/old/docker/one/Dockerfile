# Используем официальный образ Prometheus
FROM prom/prometheus

# Копируем конфигурационный файл prometheus.yml внутрь контейнера
COPY prometheus.yml /etc/prometheus/prometheus.yml

# Указываем путь к конфигурационному файлу при запуске контейнера
CMD ["--config.file=/etc/prometheus/prometheus.yml"]
