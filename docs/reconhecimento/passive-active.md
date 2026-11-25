# Reconhecimento passivo e ativo

## Passivo (sem tráfego direto ao alvo, ou tráfego mínimo em fontes públicas)

| Fonte | Informação típica |
|-------|-------------------|
| WHOIS / RDAP | contatos, nameservers, datas |
| DNS histórico / CT logs | subdomínios, certificados |
| GitHub / paste sites | credenciais vazadas (tratar com cuidado) |
| LinkedIn / vagas | stack tecnológica |

**Regra:** mesmo passivo pode violar política do cliente — confirme no escopo.

### Comandos úteis

```bash
# WHOIS + registros DNS básicos (substitua DOMINIO)
bash scripts/recon/whois-dns.sh exemplo.com.br
```

## Ativo (interação com infraestrutura do alvo)

Só com autorização explícita.

| Atividade | Risco | Mitigação |
|-----------|-------|-----------|
| Resolução em massa de subdomínios | detecção, rate limit | throttling, wordlists pequenas em prod |
| Port scan | IDS/IPS, indisponibilidade | `-T2`/`-T3`, janela acordada |
| Virtual host scan | logs no WAF | User-Agent identificável + IP de origem acordado |

### Script

```bash
bash scripts/recon/subdomains.sh -d exemplo.com.br -w wordlists/subdomains-small.txt
```

Crie wordlists locais; não versione listas gigantes no git.

## Entregáveis desta fase

- Lista de hosts confirmados no escopo
- Tecnologias identificadas (com evidência)
- Superfície exposta priorizada para varredura