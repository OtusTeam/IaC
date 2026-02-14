set -x
rm object.txt

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

pulumi up -y
yc storage bucket get "$(pulumi stack output bucketName)"
yc storage s3api get-object --bucket "$(pulumi stack output bucketName)" --key "$(pulumi stack output objectKey)" ./object.txt 
set +x
echo
echo "Содержимое объекта: $(cat object.txt)"
echo
set -x

rm object.txt
read -p "Press any key to continue..."
pulumi destroy -y
pulumi stack rm dev -y -f
