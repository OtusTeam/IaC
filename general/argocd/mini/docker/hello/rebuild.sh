set -x
docker rmi nginx1
docker commit nginx1 nginx1
docker rm -f nginx1
docker run -d --rm --name nginx1 -p 80:80 nginx1
sleep 5
curl http://localhost
