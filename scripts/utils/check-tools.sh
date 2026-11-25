#!/usr/bin/env bash
# Verifica presença de ferramentas comuns de pentest no PATH.
set -euo pipefail

TOOLS=(
  bash
  curl
  dig
  host
  nmap
  nc
  openssl
  whois
  nikto
  enum4linux
  enum4linux-ng
  smbclient
  subfinder
  httpx
)

missing=0
present=0

printf '%-20s %s\n' "FERRAMENTA" "STATUS"
printf '%s\n' "----------------------------------------"

for t in "${TOOLS[@]}"; do
  if command -v "$t" >/dev/null 2>&1; then
    printf '%-20s %s\n' "$t" "OK"
    ((present++)) || true
  else
    printf '%-20s %s\n' "$t" "ausente"
    ((missing++)) || true
  fi
done

printf '\nPresentes: %s | Ausentes: %s\n' "$present" "$missing"
if (( missing > 0 )); then
  exit 1
fi