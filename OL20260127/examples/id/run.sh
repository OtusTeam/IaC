set -x
docker run --rm alpine:3.20 id
read -p "press any key to continue..."
docker run --rm -u 4000:4000 alpine:3.20 id
