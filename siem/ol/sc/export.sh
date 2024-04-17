export SC_ANSIBLE_USER="yc-user"
export SC_IP="158.160.121.151"
export SC_LOCAL_IP="10.128.0.26"
#export DEST_IP="158.160.57.166"
export SC_DEST_IP="10.128.0.14"
export SC_AGENT_SETUP="agentsetup.txt"

echo sc ansible_host=$SC_IP ansible_user=$SC_ANSIBLE_USER > inv

echo 	"echo -e \"1\n3\n1\nA\nyc\n/mount/sc/\n*.json\nR\nY\nF\n2\nA\n0\n$SC_DEST_IP\n514\nUDP\nF\n3\nN\nY\n0\" | sudo -S /home/agent/yc_agent/agent agentsetup"	>	$SC_AGENT_SETUP
