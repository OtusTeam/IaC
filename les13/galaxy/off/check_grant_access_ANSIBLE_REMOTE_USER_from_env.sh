ansible docker -a 'groups'
ansible docker -a 'sudo cat /etc/sudoers.d/sudoers_no_password'
ansible docker -a "cat /etc/passwd" | grep ^$ANSIBLE_REMOTE_USER
