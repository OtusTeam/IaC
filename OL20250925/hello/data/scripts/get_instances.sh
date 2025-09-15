#!/usr/bin/env bash
set -euo pipefail
FOLDER_ID="${1:-}"

if [ -z "$FOLDER_ID" ]; then
  echo '{"ids_json": "[]"}'
  exit 0
fi

ids_json=$(yc compute instance list --folder-id "$FOLDER_ID" --format json | jq -c 'map(.id)')
# ids_json — допустимая JSON-строка, например: ["id1","id2"]
# Но external требует строковых значений, поэтому помещаем массив как строку
printf '{"ids_json": %s}' "$(jq -R -s -c '.' <<< "$ids_json")"
