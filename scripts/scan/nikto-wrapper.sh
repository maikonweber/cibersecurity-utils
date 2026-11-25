#!/usr/bin/env bash
# Executa nikto com tuning conservador (menos ruído).
set -euo pipefail

URL=""
OUT=""

usage() {
  echo "Uso: $0 <url> [-o arquivo.txt]"
  echo "Ex.: $0 https://alvo-autorizado.exemplo -o output/nikto.txt"
  exit "${1:-0}"
}

[[ "${1:-}" == "-h" ]] && usage 0

if ! command -v nikto >/dev/null 2>&1; then
  echo "nikto não encontrado." >&2
  exit 1
fi

if [[ "${1:-}" =~ ^https?:// ]]; then
  URL="$1"
  shift
else
  usage 1
fi

while getopts ":o:h" opt; do
  case "$opt" in
    o) OUT="$OPTARG" ;;
    h) usage 0 ;;
    *) usage 1 ;;
  esac
done

args=(-Tuning x -nointeractive -maxtime 15m)
[[ -n "$OUT" ]] && mkdir -p "$(dirname "$OUT")" && args+=(-output "$OUT")

echo "Nikto em: $URL (confirme autorização)"
nikto "${args[@]}" -h "$URL"