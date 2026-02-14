set -x

FROM_URL="https://jsonplaceholder.typicode.com/posts"

set +x
# Запрос пасфразы (не отображается при вводе)
read -rsp "Enter Pulumi passphrase: " PULUMI_CONFIG_PASSPHRASE
echo
# Экспортировать только для этого скрипта
export PULUMI_CONFIG_PASSPHRASE
pulumi stack init dev
pulumi config set yandex:token $YC_TOKEN --secret
set -x
pulumi config set yandex:cloudId $YC_CLOUD_ID
pulumi config set yandex:folderId $YC_FOLDER_ID
pulumi config set prefix $PREFIX
pulumi config set fromUrl $FROM_URL

pulumi config
#pulumi preview
pulumi up -y
pulumi stack output

read -p "press any key to destroy and remove stack ..."
				      
pulumi destroy -y

pulumi stack rm dev -y -f

set +x
