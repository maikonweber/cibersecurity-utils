# Pentest black box — referência

**Black box:** o testador **não** recebe credenciais, código-fonte nem diagramas internos. A superfície é descoberta só com informação pública e interação técnica autorizada.

## Fases (PTES resumido)

| Fase | Atividades | Artefatos |
|------|------------|-----------|
| 1. Escopo | ROE, exclusões, janela | Checklist preenchido |
| 2. Recon | DNS, subdomínios, CT, headers | Inventário de hosts |
| 3. Varredura | Nmap TCP moderado, identificação de serviço | Mapa de portas |
| 4. Enumeração web | Paths comuns, fingerprint, TLS | Tabela HTTP/códigos |
| 5. Análise | Correlação CVE, misconfig, exposição | Lista PLL-* / VULN-* |
| 6. Exploração | PoC mínima **se** escopo permitir | Evidência em `output/` |
| 7. Relatório | Executivo + técnico | Markdown/PDF |

## O que **não** entra no black box padrão deste repositório

- Brute force de senha sem limite acordado
- Fuzz de diretórios massivo (milhões de requests)
- Exploit automático sem triagem manual
- DoS ou stress test

## Automação

```bash
bash scripts/recon/blackbox-run.sh site.com.br
# Log: output/recon/blackbox-AAAAAMMDD-HHMMSS.log
```

Variáveis opcionais:

```bash
WORDLIST=wordlists/subdomains-small.txt DELAY=0.3 bash scripts/recon/blackbox-run.sh exemplo.com.br
```

## Engajamento de exemplo

[PLL — relatório black box](../engajamentos/pll-pentest/relatorio-blackbox-2025-11-25.md)