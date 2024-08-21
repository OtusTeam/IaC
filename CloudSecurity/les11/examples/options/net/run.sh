set -x
docker network create web
docker network ls
read -n 1 -s -r -p "press any key to continue..."; echo ""
echo Disable the default bridge, host, ... and use a dedicated network to expose the host interface:
docker run --rm --network=web myimage
