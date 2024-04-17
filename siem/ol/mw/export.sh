export MW_NAME="mw"
export MW_IMAGE_ID="fd8h05n39onk6uafqs2g"    # Marketplace Wazuh
#export MW_SUBNET_ID="e9bop98iu12teftg4uj8"   # otus default-ru-central1-a
export MW_SUBNET="default-ru-central1-a"
export MW_ZONE="$YC_ZONE"
export MW_SA="mw-sa"
export MW_LOG_GROUP_ID="e235llcqoau2dmt6jscv"
export MW_ANSIBLE_USER="yc-user"
export MW_IP="130.193.36.28"
echo $MW_NAME ansible_host=$MW_IP ansible_user=$MW_ANSIBLE_USER > inv 

