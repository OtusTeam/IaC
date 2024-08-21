set -x
docker run --rm alpine:3.20 id
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker run --rm -u 4000:4000 alpine:3.20 id
