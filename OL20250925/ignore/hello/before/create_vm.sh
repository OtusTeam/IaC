#!/bin/bash

export VM_NAME="hello"

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

export VM_ID=$(yc compute instance get --name $VM_NAME --format json | jq -r '.id')
