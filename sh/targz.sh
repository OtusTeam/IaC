#!/bin/bash

if [ $# -eq 1 ]; then
   echo "path=$1 will be used to create targz"
else
   echo "Call $0 path"
   exit 1
fi

mv a_*.tar.gz saved/
tar --exclude-vcs --exclude="terraform.*" --exclude ".terraform*" --exclude ".terragrunt*"  -czvf a_$(date +\%Y\%m\%d_\%H\%M\%S).tar.gz $1
