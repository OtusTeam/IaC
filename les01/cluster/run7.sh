set -x

terraform apply -var="instance_count=7"

# получаем массив IP в одну строку (JSON)
#ips_json=$(terraform output -json instance_nat_ips)
nlb_ip=$(terraform output -raw nlb_external_ip)

while true; do
# пробегаем по каждому IP и делаем curl
#  echo "$ips_json" | jq -r '.[]' | while read -r ip; do
#    echo "Instance with ip=$ip:"
#    curl -sS "http://$ip" || echo "curl failed for $ip"
#  done
  echo "Network Load Balancer with ip=$nlb_ip:"
  curl -sS "http://$nlb_ip" || echo "curl failed for $nlb_ip"
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
