set -x
mkdir -p charts
export HELM_EXPERIMENTAL_OCI=1
helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/argo/chart/argo-cd --version 7.3.11-2 \
--untar \
--untardir=argo-cd

mkdir -p ignore/infra/argo-cd/argo-cd/ #- сюда чарт argo-cd
mkdir -p ignore/infra/charts/ 		# - сюда будем добавлять чарты приложений
cp $(git rev-parse --show-toplevel)/gitignore.template ignore/infra/.gitignore	#– игнорируемые Git-файлы

cat sensitive/sa-key.json | helm registry login cr.yandex --username 'json_key' --password-stdin
helm install -n argocd --create-namespace argocd ignore/infra/argo-cd/argo-cd
kubectl -n argocd get all
read -p "Press any key to continue... (next command may be unfinished!)"
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
chromium http://localhost:8080/ &
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

echo "configs:" 										>  ignore/infra/argo-cd/argo-cd/argocd.yaml
echo "  repositories:" 										>> ignore/infra/argo-cd/argo-cd/argocd.yaml
echo "    infra:"                                                                              	>> ignore/infra/argo-cd/argo-cd/argocd.yaml
echo "      password: $(cat sensitive/project.argocd.token)"                                    >> ignore/infra/argo-cd/argo-cd/argocd.yaml
echo "      project: default"                                                                   >> ignore/infra/argo-cd/argo-cd/argocd.yaml
echo "      type: git"                                                                          >> ignore/infra/argo-cd/argo-cd/argocd.yaml
echo "      url: https://aj-$YC_PREFIX.gitlab.yandexcloud.net/$YC_PREFIX/$YC_PROJECT.git"       >> ignore/infra/argo-cd/argo-cd/argocd.yaml
echo "      username: argo-cd"                                                                  >> ignore/infra/argo-cd/argo-cd/argocd.yaml
read -p "Press any key to continue... "
helm -n argocd upgrade --install argocd ignore/infra/argo-cd/argo-cd -f ignore/infra/argo-cd/argo-cd/argocd.yaml
kubectl -n argocd get secret argocd-repo-infra
#NAME                TYPE     DATA   AGE
#argocd-repo-infra   Opaque   5      15h
set +x