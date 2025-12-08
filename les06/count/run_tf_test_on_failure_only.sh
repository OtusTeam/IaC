set -x
terraform test -filter=tests/on_failure.tftest.hcl
set +x
