#!/bin/bash

if [ $# -eq 1 ]; then
   echo "vm_name=$1 will be used to create VM"
else
   echo "Error: required parameter not specified!"
   echo "Call $0 vm_name"
   exit 1
fi

export VM_NAME="$1"
export YC_IMAGE_ID="fd8pecdhv50nec1qf9im"
export YC_SUBNET_ID="e9bop98iu12teftg4uj8"


yc compute instance create \
  --name $VM_NAME \
  --hostname $VM_NAME \
  --zone=$YC_ZONE \
  --labels group=docker \
  --create-boot-disk size=100GB,image-id=$YC_IMAGE_ID \
  --cores=2 \
  --memory=8G \
  --core-fraction=20 \
  --preemptible \
  --network-interface subnet-id=$YC_SUBNET_ID,ipv4-address=auto,nat-ip-version=ipv4 \
  --ssh-key ~/.ssh/id_rsa.pub
