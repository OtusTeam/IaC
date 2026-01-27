set -x
docker build -t cosign .

export IMAGE="ghcr.io/sigstore/cosign/cosign:v2.4.1"
echo $IMAGE will be verified:
docker run --rm cosign verify \
  --certificate-identity-regexp "^keyless@projectsigstore\\.iam\\.gserviceaccount\\.com$" \
  --certificate-oidc-issuer-regexp "^https://accounts\\.google\\.com$" $IMAGE

export IMAGE="docker.io/library/alpine:3.23"
echo $IMAGE will be verified:
docker run --rm  cosign verify --certificate-identity-regexp ".*" --certificate-oidc-issuer-regexp ".*" $IMAGE

docker image rm -f cosign
set +x
