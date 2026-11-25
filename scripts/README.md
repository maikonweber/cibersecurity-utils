# Scripts Bash

Todos os scripts assumem **autorização prévia**. Leia `-h` de cada um.

| Script | Descrição |
|--------|-----------|
| `utils/check-tools.sh` | Verifica binários comuns no PATH |
| `recon/whois-dns.sh` | WHOIS e consultas DNS básicas |
| `recon/subdomains.sh` | Brute force de subdomínios (throttled) |
| `recon/http-probe.sh` | Cabeçalhos HTTPS/HTTP por host |
| `recon/api-path-probe.sh` | Códigos HTTP em paths comuns |
| `recon/jenkins-login-probe.sh` | Mensagem de erro de login (poucos usuários, sem brute force) |
| `recon/blackbox-run.sh` | Orquestra pentest black box (recon + nmap + probes) |
| `scan/nmap-quick.sh` | Varredura TCP rápida com nmap |
| `scan/nikto-wrapper.sh` | Wrapper seguro para nikto |
| `enum/smb-enum.sh` | Enumeração SMB leve |

## Uso geral

```bash
cd /caminho/para/cibersecurity-utils
bash scripts/utils/check-tools.sh
```

Saídas recomendadas: diretório `output/` (gitignored).

## WSL / Git Bash no Windows

Paths com espaços: use aspas. Ferramentas como `nmap` devem estar no PATH do ambiente onde o Bash roda.