export WZ_ANSIBLE_USER="yc-user"
export WZ_IP="158.160.57.166"
export WZ_ALLOW_IPS="$SC_IP"
echo wazuh ansible_host=$WZ_IP ansible_user=$WZ_ANSIBLE_USER > inv
 
