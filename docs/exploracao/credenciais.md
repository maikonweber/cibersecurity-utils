# Credenciais e autenticação

## Password spraying (autorizado)

Princípios:

1. Obter lista de usuários **validada** (não inventar e-mails em produção).
2. Uma senha comum por rodada (`Season2024!` exemplo) — respeitar lockout.
3. Registrar origem IP e horário para o SOC.

## Onde testar

- VPN, OWA, O365 (*se no escopo*), SSH, painel admin, API com basic auth.
- Hash capturado em lab: `john`, `hashcat` offline — não trafegar wordlist gigante na rede do cliente sem combinar.

## Kerberos / AD (overview)

Somente em engajamentos de rede interna com equipe de AD ciente:

- AS-REP roastable accounts
- Kerberoasting (SPNs)
- ACL abuse (BloodHound) — documentar caminho, não alterar GPO sem autorização

Ferramentas: Impacket, Rubeus (Windows), BloodHound CE.

## Achados típicos no relatório

| Achado | Severidade orientativa |
|--------|-------------------------|
| Senha padrão em equipamento | Alta |
| Sem lockout / sem MFA em VPN | Alta |
| Hash NTLM capturado em lab | Média (demonstração) |
| Política de senha fraca | Média/Baixa |

## Nunca

- Compartilhar wordlists ou hashes em canais públicos.
- Reutilizar credenciais reais fora do engagement.