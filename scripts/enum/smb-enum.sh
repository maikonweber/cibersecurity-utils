#!/usr/bin/env bash
# Enumeração SMB básica via nmap scripts + enum4linux-ng se disponível.
set -euo pipefail

usage() {
  echo "Uso: $0 <ip_ou_host>"
  exit "${1:-0}"
}

[[ "${1:-}" == "-h" ]] && usage 0
[[ $# -lt 1 ]] && usage 1

TARGET="$1"

if command -v nmap >/dev/null 2>&1; then
  echo "=== nmap SMB scripts ==="
  nmap -Pn -p 445 --script smb-os-discovery,smb-security-mode,smb2-security-mode "$TARGET" || true
  nmap -Pn -p 445 --script smb-enum-shares,smb-enum-users "$TARGET" 2>/dev/null || true
else
  echo "nmap não disponível" >&2
fi

if command -v enum4linux-ng >/dev/null 2>&1; then
  echo ""
  echo "=== enum4linux-ng (resumo) ==="
  enum4linux-ng -A "$TARGET" 2>/dev/null | head -n 120 || true
elif command -v enum4linux >/dev/null 2>&1; then
  echo ""
  echo "=== enum4linux (legado) ==="
  enum4linux -a "$TARGET" 2>/dev/null | head -n 120 || true
else
  echo "enum4linux-ng/enum4linux não instalados — apenas nmap foi usado."
fi