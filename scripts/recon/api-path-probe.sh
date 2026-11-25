#!/usr/bin/env bash
# Testa códigos HTTP em caminhos comuns (recon leve).
set -euo pipefail

HOST="${1:-}"
shift || true
paths=("$@")
if [[ -z "$HOST" ]]; then
  echo "Uso: $0 <host> [/path ...]"
  exit 1
fi
if [[ ${#paths[@]} -eq 0 ]]; then
  paths=("" "/health" "/healthz" "/api" "/v1" "/swagger" "/docs" "/actuator/health" "/openapi.json")
fi

for p in "${paths[@]}"; do
  url="https://${HOST}${p}"
  code=$(curl -sSIL --max-time 12 -o /dev/null -w '%{http_code}' "$url" 2>/dev/null || echo "000")
  printf '%s\t%s\n' "$code" "$url"
done