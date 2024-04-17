export WZ_NAME="wazuh"
export WZ_IMAGE_ID="fd8s4upujl9u40j5p77l"    # Ubuntu 22.04 LTS
#export WZ_SUBNET_ID="e9bop98iu12teftg4uj8"   # otus default-ru-central1-a 
export WZ_ZONENAME="$YC_ZONE"
export WZ_SUBNET="default-ru-central1-a" 

export WZ_ANSIBLE_USER="yc-user"
export WZ_IP="158.160.57.166"
export WZ_LOCAL_IP="10.128.0.14"
export WZ_ALLOW_IPS="$SC_LOCAL_IP"
export WZ_REMOTE_CONF="ossec.remote.conf"
echo $WZ_NAME ansible_host=$WZ_IP ansible_user=$WZ_ANSIBLE_USER > inv

echo "  <remote>"					> 	$WZ_REMOTE_CONF
echo "    <connection>syslog</connection>"		>> 	$WZ_REMOTE_CONF
echo "    <port>514</port>"				>>      $WZ_REMOTE_CONF
echo "    <protocol>udp</protocol>"			>>      $WZ_REMOTE_CONF
echo "    <allowed-ips>$WZ_ALLOW_IPS/24</allowed-ips>"	>>      $WZ_REMOTE_CONF
echo "    <local_ip>$WZ_LOCAL_IP</local_ip>"		>>	$WZ_REMOTE_CONF
echo "  </remote>"					>>      $WZ_REMOTE_CONF



