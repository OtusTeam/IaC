set -x
yc managed-kubernetes cluster create \
  --name=$YC_SA \
  --public-ip \
  --network-name=$YC_NETWORK \
  --service-account-name=$YC_SA \
  --node-service-account-name=$YC_SA \
  --release-channel=rapid \
  --zone=$YC_ZONE \
  --version 1.33 \
  --security-group-ids=$(yc vpc security-group get $YC_SG --jq '.id') \
  --folder-id $YC_FOLDER_ID
set +x
