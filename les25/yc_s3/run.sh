set -x

# get cloud-id
YC_CLOUD_ID=$(yc config get cloud-id)
# set folder-id
YC_FOLDER_ID="b1gmesrdjgklgkvcp704" # otus instead $(yc config get folder-id)
# get IAM-token
#YC_TOKEN=$(yc iam create-token)

#YC_ZONE="ru-central1-a"
YC_PREFIX="les25"
FROM_URL="https://jsonplaceholder.typicode.com/posts"

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
#pulumi config set yandex:zone $YC_ZONE
pulumi config set yandex:fromUrl $FROM_URL

pulumi config
pulumi preview
pulumi up
pulumi stack output

IP="$(pulumi stack output public_ip)" 

if [ -z "$IP" ]; then
  echo "Не удалось извлечь public_ip из вывода" >&2
  exit 3
fi

echo "Public IP: $IP"

sleep 10

while true; do
  echo "Curl http://$IP/ ..."
  if curl -fsS --max-time 30 "http://$IP/"; then
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
