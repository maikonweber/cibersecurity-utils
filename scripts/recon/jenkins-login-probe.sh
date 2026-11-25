#!/usr/bin/env bash
# Um POST de login inválido por usuário (sem brute force). Compare mensagens.
set -euo pipefail

HOST="${1:-jenkins.grupopll.com.br}"
shift || true
users=("$@")
if [[ ${#users[@]} -eq 0 ]]; then
  users=(invalid.pentest.user admin administrator)
fi

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT
cookie="$tmpdir/cj"

for user in "${users[@]}"; do
  : >"$cookie"
  curl -sS -c "$cookie" -b "$cookie" "https://${HOST}/login" >/dev/null
  curl -sS -c "$cookie" -b "$cookie" -D "$tmpdir/headers.txt" -o /dev/null -X POST \
    "https://${HOST}/j_spring_security_check" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    --data "j_username=${user}&j_password=WrongPentestProbe1%21&from=%2F&Submit=Sign+in"
  loc=$(grep -i '^location:' "$tmpdir/headers.txt" | tail -1 | awk '{print $2}' | tr -d '\r' || true)
  err_path="${loc:-/loginError}"
  code=$(curl -sS -c "$cookie" -b "$cookie" \
    "https://${HOST}${err_path}" \
    -o "$tmpdir/out.html" -w '%{http_code}')
  snippet=$(grep -ioE 'Invalid username or password|incorrect username or password|Login failed|User.*not found' \
    "$tmpdir/out.html" 2>/dev/null | head -1 || true)
  if [[ -z "$snippet" ]]; then
    snippet=$(grep -oP '(?<=<h1>).*?(?=</h1>)' "$tmpdir/out.html" 2>/dev/null | head -1 || grep -i title "$tmpdir/out.html" | head -1 | sed 's/[<>]//g' || echo "(sem texto padrao)")
  fi
  printf '%s\tHTTP %s\t%s\n' "$user" "$code" "$snippet"
done