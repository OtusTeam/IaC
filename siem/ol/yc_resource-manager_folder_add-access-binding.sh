# yc config profile activate default
yc resource-manager folder add-access-binding \
  --role storage.uploader \
  --id $YC_GET_FOLDER_ID \
  --service-account-id aje5vjc1nssela771tiq 
# $YC_SA_ID

