set -x
docker container rm alpine_itd -f
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker run -itd --name alpine_itd alpine:3.20
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker ps
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker exec -it alpine_itd ps -a
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker container top alpine_itd
