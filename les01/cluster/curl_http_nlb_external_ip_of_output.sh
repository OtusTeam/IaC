set -x

ip=$(terraform output -raw nlb_external_ip)
curl -sS "http://$ip" || echo "curl failed for $ip"

set +x