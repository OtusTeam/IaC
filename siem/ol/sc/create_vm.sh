#!/bin/bash

yc compute instance create \
  --name $SC_NAME \
  --hostname $SC_NAME \
  --zone=$SC_ZONE \
  --create-boot-disk size=20GB,image-id=$SC_IMAGE_ID \
  --cores=2 \
  --memory=8G \
  --core-fraction=100 \
  --network-interface subnet-name=$SC_SUBNET,ipv4-address=auto,nat-ip-version=ipv4 \
  --ssh-key ~/.ssh/id_rsa.pub
