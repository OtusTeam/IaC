set -x
yc managed-kubernetes node-group create \
  --name=group-1 \
  --cluster-name=$YC_SA \
  --cores=2 \
  --memory=4G \
  --preemptible \
  --auto-scale=initial=1,min=1,max=2 \
  --network-interface=subnets=$YC_SUBNET,ipv4-address=nat,security-group-ids=$YC_SG_ID \
  --folder-id $YC_FOLDER_ID \
  --metadata="ssh-keys=$YC_KUBE_USER:$(cat $PUB_KEY_PATH)"
set +x