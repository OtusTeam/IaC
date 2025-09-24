#!/bin/bash

set -x
rm terraform.tfstate
terraform import yandex_compute_instance.$VM_NAME $VM_ID
