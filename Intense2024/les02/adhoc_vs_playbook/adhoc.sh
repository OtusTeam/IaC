#!/bin/bash -x

# Ping
ansible -m ping all

# File
ansible -m file -a "path=/tmp/test state=touch" all

# Command ls
ansible -m command -a "ls -la /tmp/test" all

# Template
ansible -m template -a "src=test.j2 dest=/tmp/test1" -e "yourname=John" all

# Command cat
ansible -m command -a "cat /tmp/test1" all

# Copy
ansible -m copy -a "content='Hello World!' dest=/tmp/test2" all

# Lineinfile
ansible -m lineinfile -a "path=/tmp/test2 line='Hello World!'" all

# Command cat
ansible -m command -a "cat /tmp/test2" all

# Debug
ansible -m debug -a "msg='Hello World!'" all

# Git
ansible -m git -a "repo=https://github.com/regolith-labs/ore-cli.git dest=/tmp/repo" all

# Command
ansible -m command -a "ls -la /tmp/" all

# Apt
ansible -m apt -a "name=apache2 state=present" all

# Service
ansible -m service -a "name=apache2 state=started" all | head -n 7


