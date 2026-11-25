#!/usr/bin/env bash
# Varredura TCP rápida (top ports) com detecção de versão leve.
set -euo pipefail

TARGET=""
LIST_FILE=""
OUT_DIR=""

usage() {
  echo "Uso:"
  echo "  $0 <host>"
  echo "  $0 -f <arquivo_hosts> [-o <dir_saida>]"
  exit "${1:-0}"
}

if ! command -v nmap >/dev/null 2>&1; then
  echo "nmap não encontrado no PATH." >&2
  exit 1
fi

while getopts ":f:o:h" opt; do
  case "$opt" in
    f) LIST_FILE="$OPTARG" ;;
    o) OUT_DIR="$OPTARG" ;;
    h) usage 0 ;;
    *) usage 1 ;;
  esac
done
shift $((OPTIND - 1))

if [[ -n "$LIST_FILE" ]]; then
  [[ ! -f "$LIST_FILE" ]] && { echo "Arquivo não encontrado: $LIST_FILE" >&2; exit 1; }
  [[ -n "$OUT_DIR" ]] && mkdir -p "$OUT_DIR"
  while IFS= read -r host || [[ -n "$host" ]]; do
    [[ -z "$host" || "$host" =~ ^# ]] && continue
    host="${host%%$'\r'}"
    out_arg=()
    if [[ -n "$OUT_DIR" ]]; then
      safe="$(echo "$host" | tr '/:' '__')"
      out_arg=(-oN "$OUT_DIR/nmap-${safe}.txt" -oX "$OUT_DIR/nmap-${safe}.xml")
    fi
    echo ">>> Scan: $host"
    nmap -Pn -T3 --top-ports 1000 -sV --version-light "${out_arg[@]}" "$host"
  done <"$LIST_FILE"
  exit 0
fi

[[ $# -lt 1 ]] && usage 1
TARGET="$1"

echo ">>> Scan: $TARGET"
nmap -Pn -T3 --top-ports 1000 -sV --version-light "$TARGET"