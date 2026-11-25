# OWASP Top 10 — guia rápido para testes

Versão de referência: **OWASP Top 10:2021** (ajuste quando migrar para edições mais novas).

| # | Categoria | O que testar |
|---|-----------|--------------|
| A01 | Broken Access Control | IDOR, path traversal, elevação de papel, APIs sem autorização |
| A02 | Cryptographic Failures | TLS fraco, dados sensíveis em claro, JWT mal configurado |
| A03 | Injection | SQLi, OS command, LDAP, template injection |
| A04 | Insecure Design | Lógica de negócio, fluxos sem rate limit, recuperação de conta |
| A05 | Security Misconfiguration | headers, debug, defaults, permissões em cloud |
| A06 | Vulnerable Components | dependências desatualizadas, CVEs conhecidos |
| A07 | Identification & Auth Failures | brute force, MFA bypass, sessão fixa |
| A08 | Software/Data Integrity Failures | CI/CD, atualizações não assinadas, desserialização |
| A09 | Security Logging Failures | ausência de correlação, logs sensíveis expostos |
| A10 | SSRF | URLs internas via parâmetros controláveis pelo atacante |

## Testes web mínimos (autorizado)

1. Mapear rotas e métodos (crawler manual + `robots.txt` / OpenAPI se existir).
2. Para cada recurso com ID: trocar ID de outro usuário (IDOR).
3. Inputs: payloads de injection em parâmetros, headers e corpo JSON.
4. Autenticação: política de senha, lockout, expiração de sessão, logout.
5. Cabeçalhos: CSP, HSTS, `X-Frame-Options`, cookies `Secure`/`HttpOnly`/`SameSite`.

Detalhes: [../exploracao/web.md](../exploracao/web.md)

## Ferramentas (exemplos)

- Burp Suite / OWASP ZAP (proxy)
- `nuclei`, `sqlmap` (*somente em alvos autorizados e com cuidado*)
- Análise de dependências: OWASP Dependency-Check, `npm audit`, etc.