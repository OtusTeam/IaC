set -x
ansible -i localhost, -a 'echo hello world from localhost!' all -c local
