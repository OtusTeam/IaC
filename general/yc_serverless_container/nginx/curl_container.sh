set -x
yc serverless container list 
set +x
curl -H "Authorization: Bearer $YC_TOKEN" https://$(terraform output -raw container_nginx_id).containers.yandexcloud.net/nginx
