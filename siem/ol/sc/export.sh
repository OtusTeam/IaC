export SC_NAME="sc"
export SC_IMAGE_ID="fd86picci18a45h1e3tq"    # SIEM-коннектор для Yandex Cloud
#export SC_SUBNET_ID="e9bop98iu12teftg4uj8"   # otus default-ru-central1-a 
export SC_SUBNET="default-ru-central1-a"
export SC_ZONE="$YC_ZONE"
export SC_ANSIBLE_USER="yc-user"

export SC_IP="178.154.225.220"
export SC_LOCAL_IP="10.128.0.12"
export SC_DEST_IP="10.128.0.14"
export SC_AGENT_SETUP="agentsetup.txt"

echo $SC_NAME ansible_host=$SC_IP ansible_user=$SC_ANSIBLE_USER > inv

echo 	"echo -e \"1\n3\n1\nA\nyc\n/mount/sc/\n*.json\nR\nY\nF\n2\nA\n0\n$SC_DEST_IP\n514\nUDP\nF\n3\nN\nY\n0\" | sudo -S /home/agent/yc_agent/agent agentsetup"	>	$SC_AGENT_SETUP
