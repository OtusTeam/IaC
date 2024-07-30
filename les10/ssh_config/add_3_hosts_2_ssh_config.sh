#!/bin/bash

FILE_NAME=~/.ssh/config
LOG_FILE=~/.ssh/config.bak.log

if [ -f "$FILE_NAME" ]; then
  if [ -s "$FILE_NAME" ]; then
    echo "File $FILE_NAME exists and is not empty:"
    cat "$FILE_NAME"
    read -p "Do you want to truncate it to zero length? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      DATE=$(date +"%Y-%m-%d_%H-%M-%S")
      echo "[$DATE]" >> "$LOG_FILE"
      cat "$FILE_NAME" >> "$LOG_FILE"
      > "$FILE_NAME"
      echo "File truncated to zero length."
    fi
  else
    echo "File $FILE_NAME exists but is empty."
  fi
else
  touch "$FILE_NAME"
  echo "File $FILE_NAME created with zero length."
fi

set -x #echo on
./add_host_2_ssh_config.sh one 1.1.1.1 somename ~/.ssh/id_rsa
./add_host_2_ssh_config.sh two 2.2.2.2 somename ~/.ssh/id_rsa
./add_host_2_ssh_config.sh eight 8.8.8.8 somename ~/.ssh/id_rsa
cat "$FILE_NAME"
