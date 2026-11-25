# Template de relatório de pentest

Copie esta estrutura para `reports/nome-cliente-AAAA-MM-DD.md`.

---

## 1. Resumo executivo

- **Cliente:**
- **Período do teste:**
- **Tipo:** (black box / grey / white)
- **Conclusão em uma frase:**

### Principais riscos (top 3)

1. 
2. 
3. 

## 2. Escopo e metodologia

- Escopo testado:
- Exclusões:
- Framework: PTES + OWASP WSTG (ajustar)
- Ferramentas:

## 3. Resumo de achados

| ID | Título | Severidade | Status |
|----|--------|------------|--------|
| VULN-001 | | Crítica/Alta/Média/Baixa/Info | Aberto |

## 4. Detalhamento (repetir por achado)

### VULN-XXX — Título

- **Severidade:** (CVSS vetor e score se aplicável)
- **Ativo afetado:**
- **Descrição:**
- **Impacto:**
- **Passos para reproduzir:**
  1. 
  2. 
- **Evidência:** (screenshot, request, log)
- **Remediação:**
- **Referências:** (CWE, OWASP, CVE)

## 5. Cronograma de remediação sugerido

| Prioridade | Prazo sugerido |
|------------|----------------|
| Crítica/Alta | 7–30 dias |
| Média | 30–90 dias |
| Baixa/Info | backlog |

## 6. Anexos

- Glossário
- Contas de teste utilizadas
- Hashes de arquivos de evidência

---

## Classificação de severidade (exemplo)

Use CVSS 3.1 ou matriz acordada com o cliente. Mantenha consistência em todo o relatório.