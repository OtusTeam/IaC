set -x #echo on
cat ~/.ssh/config
ansible -m ping les10-ssh-config-vm
