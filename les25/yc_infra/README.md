```bash
uv sync
# set public key
ssh-keygen -t rsa -C "your_email@example.com" -f ~/.ssh/tf-cloud-init.pub

# get SA key
yc iam service-account create --name my-sa
yc resource-manager folder add-access-binding *************************** \
  --role editor \
  --subject serviceAccount:***************************
yc iam key create --service-account-name my-sa --output sa.json
yc config set service-account-key sa.json

# get cloud-id
YC_CLOUD_ID=$(yc config get cloud-id)
# get folder-id
YC_FOLDER_ID=$(yc config get folder-id)
# get IAM-token
YC_TOKEN=$(yc iam create-token)

curl -fsSL https://get.pulumi.com | sh

pulumi config set yandex:cloudId $YC_CLOUD_ID
pulumi config set yandex:folderId $YC_FOLDER_ID
pulumi config set yandex:token $YC_TOKEN --secret
pulumi config set --secret yandex:serviceAccountKey "$(cat sa.json)"

pulumi config
pulumi preview
pulumi up
pulumi destroy






```