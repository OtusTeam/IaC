#!/bin/bash

set -x

terraform import yandex_compute_instance.$VM_NAME $VM_ID
