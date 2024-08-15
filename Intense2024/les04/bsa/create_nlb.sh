#!/bin/bash -x

if [ $# -eq 1 ]; then
   echo "nlb_name=$1 will be used to create NLB"
else
   echo "Error: required parameter not specified!"
   echo "Call $0 nlb_name"
   exit 1
fi

export NLB_NAME="$1"
export YC_SUBNET_ID="e9bop98iu12teftg4uj8"

yc load-balancer target-group create tg-$NLB_NAME \
   --target subnet-id=$YC_SUBNET_ID, address=10.128.0.36

#   --target subnet-id=$YC_SUBNET_ID, address=10.128.0.21 \
#   --target subnet-id=$YC_SUBNET_ID, address=10.128.0.25 \

read -n 1 -s -r -p "press any key to continue..."; echo ""

yc load-balancer network-load-balancer create $NLB_NAME \
   --target-group target-group-id=enpj6unfcfqj4srpjqt5,healthcheck-name=http,healthcheck-http-port=80,healthcheck-http-path=/

#   --listener name=listener-@NLB_NAME port=80, protocol=tcp, external-ip-version=ipv4 \

