set -x
docker rm alpine_itd -f
# запустим контейнер как демон
docker run -itd --name alpine_itd alpine:3.20
# docker ps
# read -p "press any key to continue..."

# посмотрим под кем выполяются процессы внутри контейнера:
docker exec -it alpine_itd ps -a
read -p "press any key to continue..."

# посмотрим под кем выполяются процесс контейнера снаружи (на хосте):
docker top alpine_itd
