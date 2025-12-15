set -x
yc managed-kubernetes cluster get-credentials --name=$YC_SA --external
kubectl get nodes
# Пример корректного вывода команды
# NAME                        STATUS   ROLES    AGE   VERSION
# cl1a9gl68r543b4673a6-ibef   Ready    <none>   1m    v1.21.5
set +x
