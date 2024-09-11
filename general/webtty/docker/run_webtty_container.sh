set -x
#export HOST_IP=$(hostname -I | awk '{print $1}')
export HOST_IP="172.18.0.1"
docker run -d --rm --net=webtty -p 3000:3000 wettyoss/wetty --ssh-host=$HOST_IP

