set -x
curl http://$(terraform output -raw lb_ip_address)
