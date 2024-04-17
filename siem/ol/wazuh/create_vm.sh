#!/bin/bash

yc compute instance create \
  --name $WZ_NAME \
  --hostname $WZ_NAME \
  --zone=$WZ_ZONE \
  --create-boot-disk size=100GB,image-id=$WZ_IMAGE_ID \
  --cores=2 \
  --memory=16G \
  --core-fraction=100 \
  --network-interface subnet-name=$WZ_SUBNET,ipv4-address=auto,nat-ip-version=ipv4 \
  --ssh-key ~/.ssh/id_rsa.pub
