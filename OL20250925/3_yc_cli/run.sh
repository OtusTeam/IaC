#!/bin/bash

set -x
VM_NAME="yc-cli"
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

yc compute instance list
rm list.json
yc compute instance list --format json > list.json
VM_ID=$(yc compute instance get --name $VM_NAME --format json | jq -r '.id')

rm vm.json
yc compute instance get --name $VM_NAME --full --format json > vm.json
cat vm.json

read -n 1 -s -r -p "Instance of VM will be DELETED in the cloud, press any key to continue..."; echo ""

yc compute instance delete --id $VM_ID
# --name $VM_NAME

