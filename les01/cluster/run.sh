set -x

terraform apply

while true; do
  ip=$(terraform output -raw nlb_external_ip)
  curl -sS "http://$ip" || echo "curl failed for $ip"
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
