set -x
docker network create --internal wetty
SSHD_IP=$(docker network inspect wetty | jq -r '.[0].IPAM.Config[0].Gateway')
docker run -d --name wetty --rm --net=wetty -p 3000:3000 wettyoss/wetty --ssh-host=$SSHD_IP
WETTY_IP=$(docker inspect wetty | jq -r '.[0].NetworkSettings.Networks.wetty.IPAddress')
sudo ufw allow from $WETTY_IP to $SSHD_IP port 22 proto tcp
chromium http://$WETTY_IP:3000/wetty

