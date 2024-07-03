#!/bin/bash

if [ $# -eq 1 ]; then
   echo "Image ID=$1 will be used to create VM"
else
   echo "Call $0 Image_ID!"
   exit 1
fi

export VM_NAME="test"
export YC_IMAGE_ID="$1"
export YC_SUBNET_ID="e9bop98iu12teftg4uj8"

yc compute instance create \
  --name $VM_NAME \
  --hostname $VM_NAME \
  --zone=$YC_ZONE \
  --create-boot-disk size=20GB,image-id=$YC_IMAGE_ID \
  --cores=2 \
  --memory=2G \
  --core-fraction=20 \
  --network-interface subnet-id=$YC_SUBNET_ID,ipv4-address=auto,nat-ip-version=ipv4 \
  --ssh-key ~/.ssh/id_rsa.pub
