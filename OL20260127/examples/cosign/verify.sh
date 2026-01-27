export IMAGE="ghcr.io/sigstore/cosign/cosign:v2.4.1"
echo $IMAGE is
if cosign verify --certificate-identity-regexp '^keyless@projectsigstore\.iam\.gserviceaccount\.com$' \
   --certificate-oidc-issuer-regexp '^https://accounts\.google\.com$' \
   $IMAGE >/dev/null 2>&1; then
  echo ok
else
  echo bad
fi

export IMAGE="docker.io/library/alpine:3.23"
echo $IMAGE is
if cosign verify --certificate-identity-regexp ".*" --certificate-oidc-issuer-regexp ".*" $IMAGE >/dev/null 2>&1; then
  echo ok
else
  echo bad
fi
