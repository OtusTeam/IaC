set -x

# получаем массив IP в одну строку (JSON)
ips_json=$(terraform output -json nat_ip_addresses)

# пробегаем по каждому IP и делаем curl
echo "$ips_json" | jq -r '.[]' | while read -r ip; do
  echo "==> $ip"
  curl -sS "http://$ip" || echo "curl failed for $ip"
done

set +x