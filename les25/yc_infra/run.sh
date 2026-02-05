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
YC_IMAGE_ID="fd84kp940dsrccckilj6"
YC_PUB_KEY_PATH="$HOME/.ssh/id_rsa.pub"

PULUMI_CONFIG_PASSPHRASE="MyVerySecurePassword"

pulumi stack init dev

pulumi config set yandex:cloudId $YC_CLOUD_ID
pulumi config set yandex:folderId $YC_FOLDER_ID
set +x
pulumi config set yandex:token $(yc iam create-token) --secret
set -x
pulumi config set yandex:prefix $YC_PREFIX
pulumi config set yandex:zone $YC_ZONE
pulumi config set yandex:cidr $YC_CIDR
pulumi config set yandex:pub $YC_PUB_KEY_PATH
pulumi config set yandex:username $YC_REMOTE_USERNAME
pulumi config set yandex:imageId $YC_IMAGE_ID

pulumi config
pulumi preview
pulumi up
pulumi destroy

pulumi stack rm dev

set +x
