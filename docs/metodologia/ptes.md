# PTES — Penetration Testing Execution Standard

Referência resumida das fases do [PTES](http://www.pentest-standard.org/). Use para estruturar tempo, entregáveis e evidências.

## 1. Pré-engagement

- Definir **objetivo** (black/grey/white box, rede, app, API, mobile).
- **Escopo**: IPs, domínios, URLs, exclusões (produção crítica, terceiros).
- **Janela**, contatos, canal de incidentes, SLA para parar se houver impacto.
- Acordo de confidencialidade e autorização legal.

Ver [escopo-checklist.md](escopo-checklist.md).

## 2. Inteligência (recon)

- Passivo: DNS, certificados, vazamentos públicos, tecnologias (Wappalyzer, Shodan *no escopo*).
- Ativo: resolução, descoberta de subdomínios *apenas se permitido*.

Docs: [../reconhecimento/passive-active.md](../reconhecimento/passive-active.md)

## 3. Ameaça e modelagem

- Atores prováveis, ativos críticos, vetores alinhados ao negócio.
- Priorizar superfícies expostas (VPN, RDP, painéis admin, APIs).

## 4. Vulnerabilidades (scan + análise)

- Scan automatizado (**com rate limit** e horário acordado).
- Triagem manual de falsos positivos.
- Mapear CVEs e configurações fracas a serviços reais.

Docs: [../varredura/port-scan-web.md](../varredura/port-scan-web.md)

## 5. Exploração

- Provar impacto com **PoC mínima** (sem exfiltrar dados desnecessários).
- Encadear achados (ex.: XSS → sessão → escalada) só dentro do escopo.

Docs: pasta [../exploracao/](../exploracao/)

## 6. Pós-exploração

- Movimento lateral, persistência e coleta de evidências **só se autorizado**.
- Documentar caminhos e limpar artefatos se combinado.

## 7. Relatório

- Executivo + técnico: contexto, metodologia, achados, risco, remediação, reteste.

Template: [../relatorio/template.md](../relatorio/template.md)

## Métricas úteis

| Métrica | Uso |
|---------|-----|
| CVSS 3.1 / 4.0 | Severidade técnica |
| Probabilidade × impacto | Priorização para negócio |
| Tempo até exploração | Urgência de correção |