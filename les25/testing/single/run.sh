set +x
# Запрос пасфразы (не отображается при вводе)
read -rsp "Enter Pulumi passphrase: " PULUMI_CONFIG_PASSPHRASE
echo
# Экспортировать только для этого скрипта
export PULUMI_CONFIG_PASSPHRASE
pulumi stack init dev
pulumi config set yandex:ycToken $YC_TOKEN --secret
set -x
pulumi config set prefix $PREFIX
pulumi config set ycCloudId $YC_CLOUD_ID
pulumi config set ycFolderId $YC_FOLDER_ID
pulumi config set ycDefaultZone $YC_ZONE
pulumi config set pubKeyPath $PUB_KEY_PATH
pulumi config set ycUsername $YC_USERNAME

read -p "Press any key to continue ..."

pulumi up

read -p "Press any key to continue ..."

pulumi destroy  -yes
pulumi stack rm dev -y
set +x
