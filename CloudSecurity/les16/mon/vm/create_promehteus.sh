#!/bin/bash

export VM_NAME="prom"
export VM_GROUP="prometheus"
export YC_IMAGE_ID="fd8t9ge4ig1mg766f31c" # Ubuntu 24.04 LTS Vanilla
# "fd8pecdhv50nec1qf9im"
export YC_SUBNET_ID="e9bop98iu12teftg4uj8"


yc compute instance create \
  --name $VM_NAME \
  --hostname $VM_NAME \
  --zone=$YC_ZONE \
  --labels group=$VM_GROUP \
  --create-boot-disk size=100GB,image-id=$YC_IMAGE_ID \
  --cores=2 \
  --memory=8G \
  --core-fraction=20 \
  --preemptible \
  --network-interface subnet-id=$YC_SUBNET_ID,ipv4-address=auto,nat-ip-version=ipv4 \
  --ssh-key ~/.ssh/id_rsa.pub
