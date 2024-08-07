#!/bin/bash

if [ -z "${ANSIBLE_INVENTORY:-}" ]; then
  echo "Error: Environment variable ANSIBLE_INVENTORY is not set or is empty."
  exit 1
fi

set -x
terraform output -raw ansible_inventory_of_vm | tee $ANSIBLE_INVENTORY
terraform output -raw ansible_inventory_of_vms | tee -a $ANSIBLE_INVENTORY

