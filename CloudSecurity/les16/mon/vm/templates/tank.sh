set -x
docker run -v $(pwd):/var/loadtest --net host -it yandex/yandex-tank
