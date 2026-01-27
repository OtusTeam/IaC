set -x
docker network create web
docker network ls
docker network inspect web
read -p "press any key to continue..."
echo Disable the default bridge, host, ... and use a dedicated network to expose the host interface:
docker run --rm --network=web alpine:3.20 ip a
docker network rm -f web
