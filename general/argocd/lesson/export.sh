export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_ZONE=$(yc config get compute-default-zone)
export YC_TOKEN=$(yc iam create-token)
export YC_FOLDER_ID=$(yc config get folder-id)
export YC_PREFIX="yc-lesson"
export YC_GL="main"
export YC_SG="$YC_PREFIX-sg"
export YC_SA="$YC_PREFIX-kube-infra"
export YC_KUBE_USER="aleksey"
export YC_NETWORK="default"
export YC_SUBNET="default-ru-central1-b"
export YC_SUBNET_ZONE="ru-central1-b"
export YC_SUBNET_CIDR="10.129.0.0/24"
export YC_NG="$YC_SA-group-1"
export YC_IG="$YC_SA-ingress-controller"

if tmp=$(yc vpc security-group get $YC_SG --jq '.id'); then
  export YC_SG_ID="$tmp"
else
  unset YC_SG_ID
fi
t1=$(yc managed-gitlab instance get $YC_GL --jq '.id')    && export YC_GL_ID="$t1"      || unset YC_GL_ID
t2=$(yc managed-kubernetes cluster get $YC_SA --jq '.id') && export YC_CLUSTER_ID="$t2" || unset YC_CLUSTER_ID

export PUB_KEY_PATH="$HOME/.ssh/id_rsa.pub"
export SEC_KEY_PATH="$HOME/.ssh/id_rsa"

export TF_VAR_yc_token="$YC_TOKEN"
export TF_VAR_yc_cloud="$YC_CLOUD_ID"
export TF_VAR_yc_default_zone="$YC_ZONE"
export TF_VAR_pub_key_path="$PUB_KEY_PATH"
export TF_VAR_sec_key_path="$SEC_KEY_PATH"
export TF_VAR_yc_folder_id="$YC_FOLDER_ID"
export TF_VAR_yc_default_zone="$YC_ZONE"
export TF_VAR_prefix="$YC_PREFIX"
