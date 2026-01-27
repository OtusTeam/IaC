set -x
sudo curl -sSLf https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64 -o /usr/local/bin/cosign
sudo chmod +x /usr/local/bin/cosign
cosign version
set +x
