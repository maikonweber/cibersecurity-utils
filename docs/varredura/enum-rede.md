# Enumeração de rede (SMB e vizinhos)

**Apenas** em redes declaradas no escopo (interno, VLAN de teste, lab).

## SMB (445/tcp)

Informações úteis em ambientes Windows/ Samba:

- Versão do SO e domínio
- Shares acessíveis (guest/anônimo)
- Usuários (quando política permite)

```bash
bash scripts/enum/smb-enum.sh 192.168.1.10
```

Dependências: `nmap`, preferencialmente `enum4linux-ng` ou `smbclient`.

## SNMP (161/udp)

Se autorizado:

```bash
nmap -sU -p 161 --script snmp-info TARGET
```

Community strings padrão são achados de **configuração**, não exploit direto.

## Documentação

Para cada host:

| Campo | Exemplo |
|-------|---------|
| IP | 192.168.1.10 |
| Hostname | FILE01.corp.local |
| Serviços | smb:445, msrpc |
| Observations | SMB signing disabled |
| Próximo teste | credenciais validadas, shares RW |

## Segurança operacional

- Não montar shares de produção sem backup/recuperação combinados.
- Evitar ransomware-like behavior (criptografia em massa, etc.).