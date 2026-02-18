set +x
# Запрос пасфразы (не отображается при вводе)
read -rsp "Enter Pulumi passphrase: " PULUMI_CONFIG_PASSPHRASE
echo
# Экспортировать только для этого скрипта
export PULUMI_CONFIG_PASSPHRASE
pulumi stack init dev
pulumi config set yandex:token $YC_TOKEN --secret
pulumi config set pub "$(cat $PUB_KEY_PATH)" --secret  	# в YAML-формате прочитать содержимое файла можно только снаружи 
set -x
pulumi config set yandex:cloudId $YC_CLOUD_ID
pulumi config set yandex:folderId $YC_FOLDER_ID
pulumi config set yandex:zone $YC_ZONE
pulumi config set cidr $YC_CIDR
pulumi config set username $YC_USERNAME
pulumi config set imageId $YC_IMAGE_ID
pulumi config set prefix $PREFIX

pulumi config
pulumi up -y
pulumi stack output

export SAVED_NAME=$(pulumi stack output subnet_name)
			    
read -p "press any key to subnet update and make drift ..."
yc vpc subnet update \
  --id $(pulumi stack output subnet_id) \
  --folder-id $YC_FOLDER_ID \
  --new-name "$PREFIX-subnet-drifted"  

read -p "press any key to detect and smooth out drift  ..."

pulumi refresh --diff # --preview-only 

read -p "press any key to destroy and remove stack ..."

pulumi destroy -y
pulumi stack rm dev -y -f

set +x
