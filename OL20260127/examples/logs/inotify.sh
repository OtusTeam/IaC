set -x
# Допустим мы хотим убедится, что в tmpfs внутри контейнера не используется для создания там исполнимых файлов 
# и возможно последующего их запуска в неизвестных (возможно вредоносных целях). 
# Или для выгрузки соотв. событий безопасности в SIEM и нахождения корреляций. 
# И т.п.
 
# сбилдим образ с мониторингом с помощью inotify изменений атрибутов файлов при различных действиях с файлами в tempfs: 
docker build -t tmpfs-monitor-img .
# запустим этот образ с логированием в json-file:
docker run -d --rm --name tmpfs-monitor --tmpfs /tmp:rw,size=100m --log-driver json-file tmpfs-monitor-img

# тут проверки, что мониторинг в контейнере установлен и запущен:
#docker exec -it tmpfs-monitor sh -c "which inotifywait || echo 'missing' || true"
#docker exec tmpfs-monitor pgrep -a inotifywait || docker exec tmpfs-monitor ps aux

# имитируем действия с файлами в tempfs без установки атрибута "исполнимый":
docker exec tmpfs-monitor sh -c "touch /tmp/exec_test && echo test > /tmp/exec_test"
# смотрим лог:
docker logs tmpfs-monitor
# имитируем действия с файлами в tempfs c установкой атрибута "исполнимый":
docker exec tmpfs-monitor sh -c 'chmod +x /tmp/exec_test'
# смотрим лог:
docker logs tmpfs-monitor
# т.е. мониторинг выявил, что какие-то действия приводят к установке атрибута "исполнимый". 
# IRL возможно затем последует попытка в неизвестных (возможно вредоносных целях) запусить этот исполнимый файл,
# и видимо надо ограничить право запускать файлы из tmpfs с помощью указания noexec для tempfs при запуске контейнера.    

# останавливаем контейнер (он автоматически удалится после остановки)
docker stop tmpfs-monitor
# удаляем ранее сбилденный образ:
docker image rm -f tmpfs-monitor-img

set +x
