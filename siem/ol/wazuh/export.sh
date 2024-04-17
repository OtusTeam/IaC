export WZ_ANSIBLE_USER="yc-user"
export WZ_IP="158.160.57.166"
export WZ_LOCAL_IP="10.128.0.14"
export WZ_ALLOW_IPS="$SC_LOCAL_IP"
export WZ_REMOTE_CONF="ossec.remote.conf"
echo wazuh ansible_host=$WZ_IP ansible_user=$WZ_ANSIBLE_USER > inv

echo "  <remote>"					> 	$WZ_REMOTE_CONF
echo "    <connection>syslog</connection>"		>> 	$WZ_REMOTE_CONF
echo "    <port>514</port>"				>>      $WZ_REMOTE_CONF
echo "    <protocol>udp</protocol>"			>>      $WZ_REMOTE_CONF
echo "    <allowed-ips>$WZ_ALLOW_IPS/24</allowed-ips>"	>>      $WZ_REMOTE_CONF
echo "    <local_ip>$WZ_LOCAL_IP</local_ip>"		>>	$WZ_REMOTE_CONF
echo "  </remote>"					>>      $WZ_REMOTE_CONF



