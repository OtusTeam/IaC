set -x
kubectl apply -f service.yaml
kubectl get service nginx
curl $(minikube service nginx --url)
