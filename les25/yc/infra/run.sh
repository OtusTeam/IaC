set +x
# Запрос пасфразы (не отображается при вводе)
read -rsp "Enter Pulumi passphrase: " PULUMI_CONFIG_PASSPHRASE
echo
# Экспортировать только для этого скрипта
export PULUMI_CONFIG_PASSPHRASE
pulumi stack init dev
pulumi config set yandex:token "$YC_TOKEN" --secret
set -x
pulumi config set yandex:cloudId $YC_CLOUD_ID
pulumi config set yandex:folderId $YC_FOLDER_ID
pulumi config set yandex:zone $YC_ZONE
#
pulumi config set username $YC_USERNAME
pulumi config set imageId $YC_IMAGE_ID
pulumi config set cidr $YC_CIDR
pulumi config set prefix $PREFIX
pulumi config set pub $PUB_KEY_PATH

pulumi config
#pulumi preview
pulumi up -y
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

read -p "press any key to destroy and remove stack ..."

pulumi destroy -y

pulumi stack rm dev -y -f

set +x
