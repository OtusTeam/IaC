set -x #echo on
cat ~/.ssh/config
ansible -i ./ssh_config.py -m ping les10-ssh-config-vm
