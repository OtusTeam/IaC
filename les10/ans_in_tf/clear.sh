#!/bin/bash

if [ -z "${ANSIBLE_INVENTORY:-}" ]; then
  echo "Error: Environment variable ANSIBLE_INVENTORY is not set or is empty."
  exit 1
fi

set -x
rm $ANSIBLE_INVENTORY

