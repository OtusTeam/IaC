set -x
# смотрим, какие установлены драйверы для логирования в docker:
docker info | grep Log
# логируем в json-file:
docker run --rm -d --name log_demo --log-driver json-file --log-opt max-size=10m --log-opt max-file=3 alpine:3.20 \
  sh -c "for i in \$(seq 1 5); do echo \"INFO: \$(date) — run \$i\"; echo \"ERR: \$(date) — error \$i\" 1>&2; sleep 1; done; sleep 3600"
sleep 1 && docker logs log_demo
sleep 1 && docker logs log_demo
sleep 1 && docker logs log_demo
sleep 1 && docker logs log_demo
docker stop log_demo
# логируем в journal:
docker run --rm -d --name log_demo --log-driver journald alpine:3.20 \
  sh -c "for i in \$(seq 1 5); do echo \"INFO: \$(date) — run \$i\"; echo \"ERR: \$(date) — error \$i\" 1>&2; sleep 1; done; sleep 3600"
sleep 1 && journalctl CONTAINER_NAME=log_demo --since "1 minute ago"
sleep 1 && journalctl CONTAINER_NAME=log_demo --since "1 minute ago"
sleep 1 && journalctl CONTAINER_NAME=log_demo --since "1 minute ago"
sleep 1 && journalctl CONTAINER_NAME=log_demo --since "1 minute ago"
docker stop log_demo
exit 0
# логируем в syslog:
docker run --rm -d --name log_demo --log-driver syslog --log-opt syslog-address=udp://127.0.0.1:514 alpine:3.20 \
  sh -c "for i in \$(seq 1 5); do echo \"INFO: \$(date) — run \$i\"; echo \"ERR: \$(date) — error \$i\" 1>&2; sleep 1; done; sleep 3600"
sleep 1 && tail /var/log/syslog
sleep 1 && tail /var/log/syslog
sleep 1 && tail /var/log/syslog
sleep 1 && tail /var/log/syslog
docker stop log_demo

set +x
