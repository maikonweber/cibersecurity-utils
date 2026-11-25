# Exploração — rede e serviços

## Fluxo geral

1. **Versão exata** do serviço (banner, patch level).
2. Buscar CVEs e exploits públicos; **reproduzir primeiro em VM** com a mesma versão.
3. Metasploit / PoC manual — uma shell ou leitura de arquivo de prova, não persistência sem autorização.

## Cenários comuns (laboratório / escopo interno)

| Serviço | Risco típico | Nota |
|---------|--------------|------|
| RDP | credenciais fracas, BlueKeep (legado) | rate limit em brute force |
| SSH | chaves vazadas, usuário `root` | usar listas pequenas |
| SMB | EternalFamily (legado), null session | patch management |
| LDAP | anonymous bind | escopo AD |

## Credenciais

Spray de senha com política acordada:

- Uma tentativa por usuário antes de lockout.
- Horário com SOC avisado.

Ver [credenciais.md](credenciais.md).

## Pós-acesso (se no escopo)

- `whoami`, grupos, trust relationships.
- **Não** exfiltrar PII real; use arquivos canary.

## Evidências

- Screenshot ou log de comando com timestamp.
- Hash de arquivo PoC se aplicável.