set -x
cat /etc/docker/daemon.json
docker info | tail -f
read -n 1 -s -r -p "press any key to continue..."; echo ""
# docker pull dockerhub.timeweb.cloud/openresty/openresty:latest
# docker pull mirror.gcr.io/ubuntu:latest
docker pull cr.yandex/mirror/alpine
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker image rm cr.yandex/mirror/alpine


