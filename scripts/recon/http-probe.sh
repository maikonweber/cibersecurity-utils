#!/usr/bin/env bash
# Cabeçalhos HTTP/HTTPS para um ou mais hosts (recon leve).
set -euo pipefail

usage() {
  echo "Uso: $0 <host> [host...]"
  exit "${1:-0}"
}

[[ $# -lt 1 ]] && usage 1

for h in "$@"; do
  echo "=== $h ==="
  for scheme in https http; do
    url="${scheme}://${h}/"
    code=$(curl -sSIL --max-time 25 -o /dev/null -w '%{http_code}' "$url" 2>/dev/null || echo "000")
    if [[ "$code" != "000" ]]; then
      echo "--- $url (final HTTP $code) ---"
      curl -sSIL --max-time 25 "$url" 2>/dev/null | head -n 25
      break
    fi
  done
  echo ""
done