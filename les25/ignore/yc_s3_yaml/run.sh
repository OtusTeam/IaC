set -x
rm object.txt

# get cloud-id
YC_CLOUD_ID=$(yc config get cloud-id)
# set folder-id
YC_FOLDER_ID="b1gmesrdjgklgkvcp704" # otus instead $(yc config get folder-id)
# get IAM-token
#YC_TOKEN=$(yc iam create-token)

YC_PREFIX="les25"

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
pulumi config set prefix $YC_PREFIX 

pulumi up
pulumi stack output
yc storage bucket get "$(pulumi stack output bucketName)"
yc storage s3api get-object --bucket "$(pulumi stack output bucketName)" --key "$(pulumi stack output objectKey)" ./object.txt 
set +x
echo
echo "Содержимое объекта: $(cat object.txt)"
echo
set -x

rm object.txt
pulumi destroy
pulumi stack rm dev

set +x
