set -x
mkdir -p charts
export HELM_EXPERIMENTAL_OCI=1
cat sensitive/sa-key.json | helm registry login cr.yandex --username 'json_key' --password-stdin
helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/yc-alb-ingress/yc-alb-ingress-controller-chart \
--version v0.2.6 \
--untar \
--untardir=charts

#export FOLDER_ID=$(yc config get folder-id)
export YC_CLUSTER_ID=$(yc managed-kubernetes cluster get $YC_SA --jq '.id')
#$(yc managed-kubernetes cluster get $YC_SA | head -n 1 | awk -F ': ' '{print $2}')

helm install \
--create-namespace \
--namespace yc-alb-ingress \
--set folderId=$YC_FOLDER_ID \
--set clusterId=$YC_CLUSTER_ID \
--set-file saKeySecretKey=sensitive/sa-key.json \
yc-alb-ingress-controller ./charts/yc-alb-ingress-controller-chart/

# Проверьте, что ресурсы создались
kubectl -n yc-alb-ingress get all
set +x