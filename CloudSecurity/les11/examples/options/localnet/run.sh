set -x
EXTERNAL_IP=$(curl -s ifconfig.me)
EXTARNAL_PORT=8080
~/examples/useful/docker_container_kill.sh nginx
docker run -d  -p $EXTARNAL_PORT:80 nginx
sleep 5
curl http://$EXTERNAL_IP:$EXTARNAL_PORT
#~/examples/useful/docker_container_kill.sh nginx
read -n 1 -s -r -p "press any key to continue..."; echo ""
EXTARNAL_PORT=8080
~/examples/useful/docker_container_kill.sh nginx
docker run -d  -p 127.0.0.1:$EXTARNAL_PORT:80 nginx
sleep 5
curl http://$EXTERNAL_IP:$EXTARNAL_PORT
curl http://127.0.0.1:$EXTARNAL_PORT
~/examples/useful/docker_container_kill.sh nginx

