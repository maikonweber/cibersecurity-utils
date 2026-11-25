# Exploração — aplicações web

## Preparação

- Proxy (Burp/ZAP) com escopo restrito ao domínio autorizado.
- Contas de teste fornecidas pelo cliente quando possível.
- Registrar **request/response** mínimos para evidência.

## Vetores por prioridade

### Controle de acesso

- Trocar IDs em URLs/API (`/api/user/123` → `124`).
- Métodos HTTP não documentados (`PUT`, `DELETE` em recurso “somente leitura”).
- Funções de admin escondidas no front, expostas na API.

### Injection

- SQLi: parâmetros numéricos e strings; time-based em segundo plano.
- Command injection: campos de ping, conversão de arquivo, webhooks.
- SSTI: templates em frameworks (Jinja, etc.) — só PoC benigna.

### Autenticação e sessão

- Cookies sem flags; JWT `alg:none` / chave fraca (testar em lab).
- Reset de senha: token previsível, sem expiração.
- MFA: bypass em fluxos legados.

### SSRF e upload

- Parâmetros `url=`, webhooks, import de imagem por URL.
- Upload: extensão dupla, `Content-Type` spoof — impacto = execução ou armazenamento malicioso?

## PoC responsável

1. Demonstre leitura de **dado de teste** criado para o pentest.
2. Evite dump de base, DoS, ou alteração em massa.
3. Inclua passos de reprodução numerados no relatório.

## Payloads e wordlists

Mantenha em `wordlists/` local (não commitar listas ofensivas gigantes). Referências: OWASP WSTG, PortSwigger Web Security Academy.