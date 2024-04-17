#!/bin/bash

yc compute instance create 								\
  --name $MW_NAME 									\
  --hostname $MW_NAME 									\
  --zone=$MW_ZONE 									\
  --create-boot-disk size=100GB,image-id=$MW_IMAGE_ID 					\
  --cores=8 										\
  --memory=32G 										\
  --core-fraction=100 									\
  --network-interface subnet-name=$MW_SUBNET,ipv4-address=auto,nat-ip-version=ipv4 	\
  --ssh-key ~/.ssh/id_rsa.pub								\
  --service-account-name $MW_SA 
