#!/bin/bash -x
cat ssh_config
echo "Press any key to continue"; read -sn 1
ansible-inventory -i ssh_config.py.ssh_config --list
