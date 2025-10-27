set -x
curl http://$(jq -r '.resources[].instances[].attributes.network_interface[].nat_ip_address' terraform.tfstate)
set +x