#!/usr/bin/env bash
# Pentest black box: recon + varredura leve (sem brute force de senha).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
DOMAIN="${1:-grupopll.com.br}"
OUT="${2:-$ROOT/output/recon/blackbox-$(date +%Y%m%d-%H%M%S).log}"
WORDLIST="${WORDLIST:-$ROOT/wordlists/subdomains-pll.txt}"
DELAY="${DELAY:-0.25}"

mkdir -p "$(dirname "$OUT")"
exec > >(tee "$OUT") 2>&1

echo "############################################"
echo "# Black box — $DOMAIN"
echo "# Início: $(date -Iseconds)"
echo "# Log: $OUT"
echo "############################################"

run() {
  echo ""
  echo ">>> $*"
  "$@" || echo "(comando retornou erro — seguindo)"
}

run bash "$ROOT/scripts/recon/whois-dns.sh" "$DOMAIN"

if [[ -f "$WORDLIST" ]]; then
  run bash "$ROOT/scripts/recon/subdomains.sh" -d "$DOMAIN" -w "$WORDLIST" -t "$DELAY"
else
  echo "Wordlist ausente: $WORDLIST"
fi

HOSTS=(
  "www.$DOMAIN"
  "api.$DOMAIN"
  "jenkins.$DOMAIN"
  "erp-b2b.$DOMAIN"
  "vpn.$DOMAIN"
  "portal.$DOMAIN"
  "omne.$DOMAIN"
)

echo ""
echo ">>> HTTP probe (hosts alvo)"
run bash "$ROOT/scripts/recon/http-probe.sh" "${HOSTS[@]}"

echo ""
echo ">>> Nmap quick (hosts com nome)"
for h in api.$DOMAIN jenkins.$DOMAIN erp-b2b.$DOMAIN vpn.$DOMAIN; do
  run bash "$ROOT/scripts/scan/nmap-quick.sh" "$h"
done

echo ""
echo ">>> API path probe"
run bash "$ROOT/scripts/recon/api-path-probe.sh" "api.$DOMAIN"
run bash "$ROOT/scripts/recon/api-path-probe.sh" "erp-b2b.$DOMAIN" / /api /api/v1 /login /health /swagger-ui /v3/api-docs

echo ""
echo ">>> Jenkins paths + login probe"
run bash "$ROOT/scripts/recon/api-path-probe.sh" "jenkins.$DOMAIN" / /login /whoAmI/api/json /view/all /manage /script
run bash "$ROOT/scripts/recon/jenkins-login-probe.sh" "jenkins.$DOMAIN"

echo ""
echo ">>> Cabeçalhos www (institucional)"
curl -sSIL --max-time 20 "https://www.$DOMAIN/" | head -n 30 || true

echo ""
echo "# Fim: $(date -Iseconds)"
echo "Log salvo em: $OUT"