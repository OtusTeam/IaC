#yc config profile activate default
yc resource-manager cloud add-access-binding \
  --role audit-trails.viewer \
  --id $YC_CLOUD_ID \
  --service-account-id aje5vjc1nssela771tiq 
# $YC_SA_ID
