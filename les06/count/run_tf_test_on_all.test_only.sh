set -x
terraform test -filter=tests/all.tftest.hcl
set +x
