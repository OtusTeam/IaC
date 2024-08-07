set -x
ansible -i '$test_ip', -m debug all
