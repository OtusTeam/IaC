set -x
yc vpc subnet create \
  --name=$YC_SUBNET \
  --network-name=$YC_NETWORK \
  --zone=$YC_SUBNET_ZONE \
  --range=$YC_SUBNET_CIDR \
  --folder-id $YC_FOLDER_ID
set +x