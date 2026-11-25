#!/usr/bin/env bash
# WHOIS + registros DNS comuns para um domínio (recon passivo/leve).
set -euo pipefail

usage() {
  sed -n '2,8p' "$0" | sed 's/^# \{0,1\}//'
  echo ""
  echo "Uso: $0 <dominio>"
  echo "Ex.: $0 exemplo.com.br"
  exit "${1:-0}"
}

[[ "${1:-}" == "-h" || "${1:-}" == "--help" ]] && usage 0
[[ $# -lt 1 ]] && usage 1

DOMAIN="$1"

echo "=== WHOIS: $DOMAIN ==="
if command -v whois >/dev/null 2>&1; then
  whois "$DOMAIN" 2>/dev/null | head -n 80 || echo "(whois falhou ou truncado)"
else
  echo "whois não instalado"
fi

echo ""
echo "=== DNS (dig) ==="
for rtype in A AAAA MX NS TXT SOA; do
  echo "--- $rtype ---"
  if command -v dig >/dev/null 2>&1; then
    dig +short "$DOMAIN" "$rtype" || true
  else
    host -t "$rtype" "$DOMAIN" 2>/dev/null || true
  fi
done

echo ""
echo "=== SPF/DMARC (se existir) ==="
if command -v dig >/dev/null 2>&1; then
  dig +short "_dmarc.$DOMAIN" TXT || true
fi