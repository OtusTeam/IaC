set -x
export DOCKER_CONTENT_TRUST=1
docker run --rm alpine:3.20 id
docker run --rm myimage
export DOCKER_CONTENT_TRUST=0
docker run --rm alpine:3.20 id
docker run --rm myimage
unset DOCKER_CONTENT_TRUST
