#!/bin/bash

set -x
VM_NAME="import"

YC_IMAGE_ID="fd8pecdhv50nec1qf9im"
YC_SUBNET_ID="e9bop98iu12teftg4uj8"

yc compute instance create \
  --name $VM_NAME \
  --hostname $VM_NAME \
  --zone=$YC_ZONE \
  --create-boot-disk size=20GB,image-id=$YC_IMAGE_ID \
  --cores=2 \
  --memory=2G \
  --core-fraction=20 \
  --preemptible \
  --network-interface subnet-id=$YC_SUBNET_ID,ipv4-address=auto,nat-ip-version=ipv4 \
  --ssh-key ~/.ssh/id_rsa.pub

VM_ID=$(yc compute instance get --name $VM_NAME --format json | jq -r '.id')

rm terraform.tfstate
ls
terraform import yandex_compute_instance.$VM_NAME $VM_ID
cat terraform.tfstate
terraform show -json

read -n 1 -s -r -p "Instance of VM will be DELETED in the cloud, press any key to continue..."; echo ""

yc compute instance delete --id $VM_ID
# --name $VM_NAME

