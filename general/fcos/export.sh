export PREFIX="fcos"
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_ZONE="ru-central1-b" 			#$(yc config get compute-default-zone)
export YC_TOKEN=$(yc iam create-token)
export YC_FOLDER_ID="b1ggm2k4duhi62vkadtq"	# sand
export YC_SUBNET_ID="e2l0ngd4doggtiuk1cbu" 	# "default-ru-central1-b"
export YC_USERNAME="core"
export YC_IMAGE_ID="fd865udut6b1gvgh5igh" 	# Fedora CoreOS 35
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
export TF_VAR_pub_key_path="$PUB_KEY_PATH"
export TF_VAR_sec_key_path="$SEC_KEY_PATH"
