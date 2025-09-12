set -x

yc iam service-account create --name folderviewer --description OL20250925 

export YC_VIEWER_SA_ID=$(yc iam service-account get --name folderviewer --format json | jq -r '.id')

yc resource-manager folder add-access-binding otus --role viewer --subject serviceAccount:$YC_VIEWER_SA_ID

export YC_TOKEN=$(yc iam create-token --impersonate-service-account-id $YC_VIEWER_SA_ID)
export TF_VAR_yc_token="$YC_TOKEN"

set | grep YC_
set | grep TF_VAR_

set +x
