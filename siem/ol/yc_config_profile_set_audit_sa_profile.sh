yc config profile activate audit-sa-profile
yc config set service-account-key audit_sa_key.sensitive.json
yc config set cloud-id $YC_CLOUD_ID
yc config set compute-default-zone $YC_ZONE
yc config set folder-id $YC_GET_FOLDER_ID

