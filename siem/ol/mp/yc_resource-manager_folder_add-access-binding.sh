# yc config profile activate default
yc resource-manager folder add-access-binding \
  --role yds.editor \
  --id $YC_GET_FOLDER_ID \
  --service-account-id ajevofu72sng1un31f6i
# $YC_SA_ID

