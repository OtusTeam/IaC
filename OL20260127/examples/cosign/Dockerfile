FROM ghcr.io/sigstore/cosign/cosign:v2.4.1 as cosign-bin

# Source: https://github.com/chainguard-images/static
FROM cgr.dev/chainguard/static:latest
COPY --from=cosign-bin /ko-app/cosign /usr/local/bin/cosign
ENTRYPOINT [ "cosign" ]