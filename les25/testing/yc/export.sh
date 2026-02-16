export PREFIX="les25"
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_ZONE=$(yc config get compute-default-zone)
export YC_TOKEN=$(yc iam create-token)
export YC_FOLDER_ID="b1gphr6mcggqjvd9kl4h"	# test
# TODO: find and remove vars:
#export YC_SUBNET_ID="e9bjdd84pueqaq0ki9tf"	# test
export YC_USERNAME="ubuntu"
export YC_CIDR="192.168.25.0/25" 
export YC_IMAGE_ID="fd85r147n5huljgijb47" 	# LEMP insead "fd84kp940dsrccckilj6" Ubunta 22.04 LTS
export PUB_KEY_PATH="$HOME/.ssh/id_rsa.pub"
export SEC_KEY_PATH="$HOME/.ssh/id_rsa"


export TF_VAR_prefix="$PREFIX"
export TF_VAR_yc_token="$YC_TOKEN"
export TF_VAR_yc_cloud_id="$YC_CLOUD_ID"
export TF_VAR_yc_folder_id="$YC_FOLDER_ID"
export TF_VAR_yc_subnet_id="$YC_SUBNET_ID"
export TF_VAR_yc_default_zone="$YC_ZONE"
export TF_VAR_yc_username="$YC_USERNAME"
export TF_VAR_yc_image_id="$YC_IMAGE_ID" 	
export TF_VAR_yc_cidr="$YC_CIDR" 
export TF_VAR_pub_key_path="$PUB_KEY_PATH"
export TF_VAR_sec_key_path="$SEC_KEY_PATH"
