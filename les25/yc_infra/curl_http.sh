#!/usr/bin/env bash
set -euo pipefail

read -rsp "Enter Pulumi passphrase: " PULUMI_CONFIG_PASSPHRASE
echo
export PULUMI_CONFIG_PASSPHRASE

raw=$(pulumi stack output --json 2>/dev/null || true)

if [ -z "$raw" ]; then
  echo "Не удалось получить outputs из pulumi" >&2
  exit 2
fi

if command -v jq >/dev/null 2>&1; then
  ip=$(printf '%s' "$raw" | jq -r 'if .public_ip then .public_ip elif .public_ip.value then .public_ip.value else empty end')
else
  ip=$(printf '%s' "$raw" | grep -oP '"public_ip"\s*:\s*"\K[^"]+' || true)
fi

if [ -z "$ip" ]; then
  echo "Не удалось извлечь public_ip из вывода" >&2
  exit 3
fi

echo "Public IP: $ip"

while true; do
  sleep 10
  echo "Curl http://$ip/ ..."
  if curl -fsS --max-time 30 "http://$ip/"; then
    echo "curl succeeded, exiting."
    break
  else
    echo "curl failed."
    # спросить пользователя, отменить ли
    read -rp "cancel (y/N)? " ans
    case "${ans,,}" in
      y|yes)
        echo "Cancelled by user."
        exit 0
        ;;
      *)
        echo "Retrying..."
        ;;
    esac
  fi
done
