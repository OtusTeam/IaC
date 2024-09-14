set -x
eval $(minikube docker-env)
docker rmi nginx1
docker commit nginx1 nginx1:1
docker rm -f nginx1
docker run -d --rm --name nginx1 -p 8888:80 nginx1:1
sleep 5
curl http://$(minikube ip):8888
docker rm -f nginx1
