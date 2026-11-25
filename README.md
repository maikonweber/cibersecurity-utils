# cibersecurity-utils

Repositório de **documentação e scripts auxiliares** para testes de intrusão (pentest) e exploração de vulnerabilidades — em português.

## Aviso legal

Use este material **somente** em ambientes onde você tem **autorização explícita por escrito** (contrato, escopo assinado, laboratório próprio ou plataformas legais como Hack The Box, TryHackMe, DVWA, etc.). Testes não autorizados são crime.

## Estrutura

| Pasta | Conteúdo |
|-------|----------|
| [`docs/`](docs/README.md) | Guias em Markdown (metodologia, recon, scan, exploração, relatório) |
| [`scripts/`](scripts/README.md) | Scripts Bash reutilizáveis (recon, varredura, enumeração) |

## Como começar

1. Leia [`docs/metodologia/ptes.md`](docs/metodologia/ptes.md) para alinhar fases do teste.
2. Confira se as ferramentas estão instaladas: `bash scripts/utils/check-tools.sh`
3. Siga o fluxo sugerido em [`docs/README.md`](docs/README.md).

## Pré-requisitos (scripts)

- Bash (Git Bash / WSL / Linux / macOS)
- Ferramentas opcionais conforme o script: `nmap`, `dig`, `whois`, `nikto`, `enum4linux`, etc.

## Contribuição

Adicione novos tópicos em `docs/` e automações seguras em `scripts/`, sempre documentando escopo, risco e pré-requisitos.