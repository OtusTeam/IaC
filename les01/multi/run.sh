set -x

terraform apply

while true; do
  # получаем массив IP в одну строку (JSON)
  ips_json=$(terraform output -json nat_ip_addresses)
  # пробегаем по каждому IP и делаем curl
  echo "$ips_json" | jq -r '.[]' | while read -r ip; do
    echo "==> $ip"
    curl -sS "http://$ip" || echo "curl failed for $ip"
  done
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
