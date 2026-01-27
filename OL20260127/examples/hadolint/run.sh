set -x
export IMAGE="hadolint/hadolint:v2.14.0-alpine"
docker run --rm -i $IMAGE < Dockerfile
docker image rm -f $IMAGE
set +x