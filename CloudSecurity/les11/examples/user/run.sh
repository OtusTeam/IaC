set -x
docker run --rm alpine:3.20 id
read -n 1 -s -r -p "press any key to continue..."; echo ""
cat Dockerfile
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker build -t myimage .
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker run --rm myimage
