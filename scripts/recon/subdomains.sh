#!/usr/bin/env bash
# Brute force de subdomínios com throttling (use apenas com autorização).
set -euo pipefail

DELAY_SEC=0.2
DOMAIN=""
WORDLIST=""

usage() {
  echo "Uso: $0 -d <dominio> -w <wordlist>"
  echo "  -d   domínio base (ex.: exemplo.com)"
  echo "  -w   arquivo com um rótulo por linha (www, mail, api)"
  echo "  -t   delay entre consultas em segundos (padrão: $DELAY_SEC)"
  exit "${1:-0}"
}

while getopts ":d:w:t:h" opt; do
  case "$opt" in
    d) DOMAIN="$OPTARG" ;;
    w) WORDLIST="$OPTARG" ;;
    t) DELAY_SEC="$OPTARG" ;;
    h) usage 0 ;;
    *) usage 1 ;;
  esac
done

[[ -z "$DOMAIN" || -z "$WORDLIST" ]] && usage 1
[[ ! -f "$WORDLIST" ]] && { echo "Wordlist não encontrada: $WORDLIST" >&2; exit 1; }

if ! command -v dig >/dev/null 2>&1 && ! command -v host >/dev/null 2>&1; then
  echo "Instale dig ou host." >&2
  exit 1
fi

echo "# Subdomínios resolvidos para $DOMAIN ($(date -Iseconds 2>/dev/null || date))"
found=0

while IFS= read -r label || [[ -n "$label" ]]; do
  [[ -z "$label" || "$label" =~ ^# ]] && continue
  label="${label%%$'\r'}"
  fqdn="${label}.${DOMAIN}"

  ip=""
  if command -v dig >/dev/null 2>&1; then
    ip="$(dig +short +time=2 +tries=1 "$fqdn" A 2>/dev/null | head -n1 || true)"
  else
    ip="$(host -t A "$fqdn" 2>/dev/null | awk '/has address/ {print $4; exit}' || true)"
  fi

  if [[ -n "$ip" ]]; then
    printf '%s\t%s\n' "$fqdn" "$ip"
    ((found++)) || true
  fi

  sleep "$DELAY_SEC"
done <"$WORDLIST"

echo "# Total encontrados: $found" >&2