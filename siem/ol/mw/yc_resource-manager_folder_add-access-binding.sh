yc resource-manager folder add-access-binding \
  --role compute.viewer \
  --id $YC_GET_FOLDER_ID \
  --service-account-id ajeo3f9qr5tlur3h6f1n 

yc resource-manager folder add-access-binding \
  --role logging.viewer \
  --id $YC_GET_FOLDER_ID \
  --service-account-id ajeo3f9qr5tlur3h6f1n 

yc resource-manager folder add-access-binding \
  --role logging.reader \
  --id $YC_GET_FOLDER_ID \
  --service-account-id ajeo3f9qr5tlur3h6f1n 

yc resource-manager folder add-access-binding \
  --role logging.writer \
  --id $YC_GET_FOLDER_ID \
  --service-account-id ajeo3f9qr5tlur3h6f1n 

# $YC_MW_SA_ID

