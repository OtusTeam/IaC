#set -x
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_ZONE=$(yc config get compute-default-zone)
export YC_TOKEN=$(yc iam create-token)
export YC_FOLDER_ID="b1gmesrdjgklgkvcp704"              # otus

export ANSIBLE_REMOTE_USER="ubuntu"
export ANSIBLE_INVENTORY="./inv"

export TF_VAR_yc_token="$YC_TOKEN"
export TF_VAR_yc_cloud="$YC_CLOUD_ID"
export TF_VAR_yc_default_zone="$YC_ZONE"
export TF_VAR_pub_key_path="~/.ssh/id_rsa.pub"
export TF_VAR_sec_key_path="~/.ssh/id_rsa"
export TF_VAR_prefix="gitlab-runner"
export TF_VAR_username="$ANSIBLE_REMOTE_USER"
#export TF_VAR_pub_key_file="$PUB_KEY_FILE"
export TF_VAR_yc_folder="b1gmesrdjgklgkvcp704"
export TF_VAR_yc_default_zone="$YC_ZONE"
export TF_VAR_yc_subnet_id="e9bop98iu12teftg4uj8"
#set +x
