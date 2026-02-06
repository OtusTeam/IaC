set +x
# Запрос пасфразы (не отображается при вводе)
read -rsp "Enter Pulumi passphrase: " PULUMI_CONFIG_PASSPHRASE
echo
# Экспортировать только для этого скрипта
export PULUMI_CONFIG_PASSPHRASE
pulumi stack init dev
set -x

pulumi up

URL="$(pulumi stack output url)"
docker ps
sleep 10
curl "$URL"
curl "$URL"
curl "$URL"

pulumi destroy
pulumi stack rm dev
docker ps -a
docker image rm app:latest
docker image rm redis:6.2

set +x
