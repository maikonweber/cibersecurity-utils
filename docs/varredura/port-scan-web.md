# Varredura de portas e superfície web

## Nmap — perfis seguros para pentest autorizado

| Perfil | Quando usar |
|--------|-------------|
| Quick TCP top ports | triagem inicial |
| `-sV` version detection | confirmar serviço antes de exploits |
| `-sC` default scripts | cuidado em produção; pode ser intrusivo |

### Script do repositório

```bash
# Alvo único
bash scripts/scan/nmap-quick.sh 10.0.0.5

# Lista de hosts (um IP/FQDN por linha)
bash scripts/scan/nmap-quick.sh -f hosts.txt -o output/scan
```

## Serviços web

Após identificar `80/tcp`, `443/tcp`, `8080/tcp`, etc.:

1. Identificar stack (Server header, páginas de erro, favicon hash).
2. Mapear diretórios com **taxa baixa** (ffuf, gobuster) na janela acordada.
3. Scan automatizado leve:

```bash
bash scripts/scan/nikto-wrapper.sh https://alvo-autorizado.exemplo
```

Nikto gera muito ruído — valide manualmente.

## Triagem de resultados

| Achado scan | Ação |
|-------------|------|
| Porta inesperada aberta | confirmar firewall, documentar |
| Versão antiga com CVE | correlacionar CVE, testar PoC em lab |
| TLS 1.0 / cipher fraco | item de configuração no relatório |
| HTTP sem redirect HTTPS | misconfiguration |

## Referência de enumeração SMB

Se porta `445` estiver **no escopo**:

→ [enum-rede.md](enum-rede.md)