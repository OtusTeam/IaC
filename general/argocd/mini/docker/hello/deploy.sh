set -x
eval $(minikube docker-env)
kubectl create deployment nginx1 --image=nginx1:1
kubectl get deployments nginx1
kubectl get pods nginx1
kubectl get services
kubectl expose deployment nginx1 --type=NodePort --port=80
kubectl get services nginx1
sleep 5
minikube service nginx1
curl $(minikube service nginx1 --url)
kubectl delete service,deployment nginx1
