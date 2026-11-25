# OSINT e superfície de ataque

## Objetivo

Mapear **ativos públicos** ligados ao escopo sem extrapolar para terceiros.

## Checklist OSINT (escopo permitido)

1. **Domínio raiz** e variações típicas (typos — só se autorizado).
2. **Certificados** (Certificate Transparency): nomes alternativos.
3. **ASN e blocos** anunciados — cruze com lista de IPs no contrato.
4. **E-mail e SPF/DKIM/DMARC** — configuração fraca não é “hack”, mas informa phishing risk.
5. **Exposição de painéis** (admin, vpn, webmail) — documentar URL, não explorar fora do escopo.

## Boas práticas

- Salve screenshots e timestamps das fontes.
- Não armazene dados pessoais além do necessário para o relatório (LGPD/GDPR).
- Diferencie **fato** (DNS resolve) de **hipótese** (serviço vulnerável).

## Ferramentas (instalação local)

| Ferramenta | Uso |
|------------|-----|
| `amass`, `subfinder` | subdomínios (modo passivo quando possível) |
| `theHarvester` | e-mails e hosts públicos |
| `httpx` | validar hosts vivos após descoberta |

Integre saídas em `output/recon/` (pasta ignorada pelo git).

## Próximo passo

[Varredura de portas e serviços web](../varredura/port-scan-web.md)