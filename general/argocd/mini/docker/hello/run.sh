set -x
docker rm -f nginx1
docker run -d --rm -p 80:80 --name nginx1 --hostname nginx1 nginx
docker cp index.html nginx1:/usr/share/nginx/html/index.html
docker cp nginx.conf nginx1:/etc/nginx/nginx.conf
docker exec -d nginx1 service nginx reload
curl http://localhost
