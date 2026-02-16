deactivate
source .venv/bin/activate
set +x
# Запрос пасфразы (не отображается при вводе)
read -rsp "Enter Pulumi passphrase: " PULUMI_CONFIG_PASSPHRASE
echo
# Экспортировать только для этого скрипта
export PULUMI_CONFIG_PASSPHRASE
pulumi stack init test
set -x

pulumi up -y

set +x

set -uo pipefail   # НЕ ставим -e, чтобы не падать на первом тесте

failures=0

run_test () {
  local name="$1"
  shift

  if "$@"; then
    echo "$name tested OK"
  else
    echo "$name FAILED"
    ((failures++))
  fi
}

echo "Running Pulumi tests..."
echo

outputs=$(pulumi stack output --json)

########################################
# TESTS
########################################

run_test "helloWorld output exists" \
  jq -e '.helloWorld != null' <<< "$outputs" >/dev/null

run_test "helloWorld has correct value" \
  jq -e '.helloWorld == "Hello, World!"' <<< "$outputs" >/dev/null


########################################
# RESULT
########################################

echo
if ((failures == 0)); then
  echo "All tests passed successfully!"
#  exit 0
else
  echo "$failures test(s) failed"
#  exit 1
fi

echo

set -x

pulumi destroy -y
pulumi stack rm test -y -f
set +x
