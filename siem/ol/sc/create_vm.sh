#!/bin/bash

export VM_NAME="sc"
export YC_IMAGE_ID="fd86picci18a45h1e3tq"    # SIEM-коннектор для Yandex Cloud
export YC_SUBNET_ID="e9bop98iu12teftg4uj8"   # otus default-ru-central1-a 

yc compute instance create \
  --name $VM_NAME \
  --hostname $VM_NAME \
  --zone=$YC_ZONE \
  --create-boot-disk size=20GB,image-id=$YC_IMAGE_ID \
  --cores=2 \
  --memory=8G \
  --core-fraction=100 \
  --network-interface subnet-id=$YC_SUBNET_ID,ipv4-address=auto,nat-ip-version=ipv4 \
  --ssh-key ~/.ssh/id_rsa.pub
