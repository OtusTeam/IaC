export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_ZONE=$(yc config get compute-default-zone)
export YC_TOKEN=$(yc iam create-token)

export TF_VAR_yc_token="$YC_TOKEN"
export TF_VAR_yc_cloud="$YC_CLOUD_ID"
export TF_VAR_yc_default_zone="$YC_ZONE"
export TF_VAR_pub_key_path="~/.ssh/id_rsa.pub"
export TF_VAR_sec_key_path="~/.ssh/id_rsa"
export TF_VAR_yc_folder="b1gmesrdjgklgkvcp704"
export TF_VAR_yc_default_zone="$YC_ZONE"
export TF_VAR_yc_subnet_id="e9bop98iu12teftg4uj8"
export TF_VAR_prefix="les04"
