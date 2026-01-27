set -x
# получаем внешний ip:
EXTERNAL_IP=$(ip -4 addr show | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v "127.0.0.1" | head -n 1)
echo $EXTERNAL_IP
EXTARNAL_PORT=8080
../../useful/docker_container_kill.sh nginx
# запускаем в контейнере nginx без указания ip:
docker run -d  -p $EXTARNAL_PORT:80 nginx
sleep 5
# проверяем доступ по внешнему ip:
curl http://$EXTERNAL_IP:$EXTARNAL_PORT
read -p "press any key to continue..."
EXTARNAL_PORT=8080
../../useful/docker_container_kill.sh nginx
# запускаем в контейнере nginx с явным указанием ip=127.0.0.1:
docker run -d  -p 127.0.0.1:$EXTARNAL_PORT:80 nginx
sleep 5
# проверяем доступ по внешнему ip:
curl http://$EXTERNAL_IP:$EXTARNAL_PORT
# проверяем доступ по внуреннему ip=127.0.0.1::
curl http://127.0.0.1:$EXTARNAL_PORT
../../useful/docker_container_kill.sh nginx
# удаляем образ nginx:
docker image rm -f nginx
set +x