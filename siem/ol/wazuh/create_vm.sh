#!/bin/bash

export VM_NAME="wazuh"
export YC_IMAGE_ID="fd8s4upujl9u40j5p77l"    # Ubuntu 22.04 LTS
export YC_SUBNET_ID="e9bop98iu12teftg4uj8"   # otus default-ru-central1-a 

yc compute instance create \
  --name $VM_NAME \
  --hostname $VM_NAME \
  --zone=$YC_ZONE \
  --create-boot-disk size=100GB,image-id=$YC_IMAGE_ID \
  --cores=2 \
  --memory=16G \
  --core-fraction=100 \
  --network-interface subnet-id=$YC_SUBNET_ID,ipv4-address=auto,nat-ip-version=ipv4 \
  --ssh-key ~/.ssh/id_rsa.pub
