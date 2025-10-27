set -x

terraform apply

while true; do
  curl http://$(jq -r '.resources[].instances[].attributes.network_interface[].nat_ip_address' terraform.tfstate)
  read -r -n1 -p "Press Y to destroy or any key to wait: " ans
  echo
  if [[ $ans == 'Y' ]]; then
    break
  fi
  sleep 1  # опционально: пауза перед повтором
done

# дальше — действия по уничтожению
echo "Destroying..."
terraform destroy

set +x
