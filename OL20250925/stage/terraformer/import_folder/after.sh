set -x

yc iam service-account delete  --name folderviewer

unset YC_TOKEN
unset TF_VAR_yc_token
unset YC_VIEWER_SA_ID

set | grep YC_

set +x