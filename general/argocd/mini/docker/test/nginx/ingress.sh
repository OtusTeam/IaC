set -x
kubectl apply -f ingress.yaml
#kubectl get service nginx
#curl $(minikube service nginx --url)
kubectl get ingress nginx
curl http://$(minikube ip)

HOST_ENTRY="$(minikube ip) nginx.local"

if ! grep -q "$HOST_ENTRY" /etc/hosts; then
  echo "$HOST_ENTRY" | sudo tee -a /etc/hosts
fi

curl http://nginx.local
