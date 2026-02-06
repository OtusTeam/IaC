set -x

# get cloud-id
YC_CLOUD_ID=$(yc config get cloud-id)
# get folder-id
YC_FOLDER_ID="b1gmesrdjgklgkvcp704" # otus instead $(yc config get folder-id)
# get IAM-token
#YC_TOKEN=$(yc iam create-token)

YC_ZONE="ru-central1-a"
YC_CIDR="192.168.25.0/25" 
YC_PREFIX="les25"
YC_REMOTE_USERNAME="ubuntu"
YC_IMAGE_ID="fd85r147n5huljgijb47" # LEMP insead "fd84kp940dsrccckilj6" Ubunta 22.04 LTS
YC_PUB_KEY_PATH="$HOME/.ssh/id_rsa.pub"


set +x
# Запрос пасфразы (не отображается при вводе)
read -rsp "Enter Pulumi passphrase: " PULUMI_CONFIG_PASSPHRASE
echo
# Экспортировать только для этого скрипта
export PULUMI_CONFIG_PASSPHRASE
pulumi stack init dev
pulumi config set yandex:token $(yc iam create-token) --secret
set -x
pulumi config set yandex:cloudId $YC_CLOUD_ID
pulumi config set yandex:folderId $YC_FOLDER_ID
pulumi config set yandex:prefix $YC_PREFIX
pulumi config set yandex:zone $YC_ZONE
pulumi config set yandex:cidr $YC_CIDR
pulumi config set yandex:pub $YC_PUB_KEY_PATH
pulumi config set yandex:username $YC_REMOTE_USERNAME
pulumi config set yandex:imageId $YC_IMAGE_ID

pulumi config
pulumi preview
pulumi up
pulumi stack output

# Получить JSON-вывод всех outputs
raw=$(pulumi stack output --json 2>/dev/null || true)

if [ -z "$raw" ]; then
  echo "Не удалось получить outputs из pulumi" >&2
  exit 2
fi

# Извлечь public_ip
if command -v jq >/dev/null 2>&1; then
  ip=$(printf '%s' "$raw" | jq -r 'if .public_ip then .public_ip elif .public_ip.value then .public_ip.value else empty end')
else
  # простая парсинг-альтернатива: найти строку с "public_ip"
  ip=$(printf '%s' "$raw" | grep -oP '"public_ip"\s*:\s*"\K[^"]+' || true)
fi

if [ -z "$ip" ]; then
  echo "Не удалось извлечь public_ip из вывода" >&2
  exit 3
fi

echo "Public IP: $ip"

sleep 10

while true; do
  echo "Curl http://$ip/ ..."
  if curl -fsS --max-time 30 "http://$ip/"; then
    echo "curl succeeded, exiting."
    break
  else
    echo "curl failed."
    # спросить пользователя, отменить ли
    read -rp "cancel (y/N)? " ans
    case "${ans,,}" in
      y|yes)
        echo "Cancelled by user."
        exit 0
        ;;
      *)
        echo "Retrying..."
        ;;
    esac
  fi
done

pulumi destroy

pulumi stack rm dev

set +x
