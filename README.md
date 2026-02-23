# 📦 ERP Inventory Risk Analytics com dbt

## 🎯 Contexto de Negócio

No varejo, rupturas de estoque geram perda de receita e impactam diretamente a experiência do cliente.
Este projeto simula um módulo analítico de um ERP, com foco em identificar risco de ruptura de estoque e sugerir reposição inteligente baseada no consumo real.

---

## 🧠 Objetivo

Construir um modelo analítico capaz de:

- Calcular média móvel de consumo (7 dias)
- Monitorar histórico de estoque com Snapshot (SCD Type 2)
- Estimar dias de cobertura de estoque
- Identificar produtos com risco de ruptura
- Simular necessidade de reposição para cobertura alvo

---

## 🏗 Arquitetura de Dados

O projeto foi estruturado seguindo boas práticas de Analytics Engineering:

### Camadas:

- **Seeds (Raw)** → Dados simulados de vendas e estoque
- **Staging** → Padronização e limpeza
- **Snapshot** → Controle histórico de estoque (SCD Type 2)
- **Marts** → Modelos finais orientados ao negócio

---

## 📊 Modelo Principal: `fct_inventory_risk`

Grão:  
1 linha por produto, por loja, por dia.

### Métricas calculadas:

- `avg_daily_consumption_7d` → Média móvel de vendas
- `days_of_stock` → Dias estimados de cobertura
- `is_stockout_risk` → Flag de risco (≤ 3 dias)
- `suggested_replenishment` → Quantidade sugerida para atingir 7 dias de cobertura

---

## 📈 Exemplos de Análises Geradas

- Ranking de produtos mais críticos
- Impacto financeiro potencial da ruptura
- Lojas com maior exposição a risco
- Simulação de reposição inteligente

---

## 🛠 Tecnologias Utilizadas

- dbt
- BigQuery
- SQL (CTEs, Window Functions)
- Snapshot (SCD Type 2)
- Git / GitHub

---

## 🚀 Diferenciais Técnicos

✔ Modelagem em camadas  
✔ Uso de Window Functions para métricas temporais  
✔ Controle histórico de estoque via Snapshot  
✔ Regras de negócio aplicadas ao modelo  
✔ Simulação estratégica de reposição  

---

## 📌 Aprendizados

Este projeto reforçou conceitos de:

- Engenharia de Analytics
- Modelagem orientada a negócio
- Métricas operacionais de varejo
- Qualidade e organização de projeto dbt

---

# 🇺🇸 README – English Version

## 🎯 Business Context

In retail, stockouts directly impact revenue and customer experience.
This project simulates an ERP analytics module focused on detecting stockout risk and suggesting intelligent replenishment based on real consumption data.

---

## 🧠 Objective

Build an analytical model capable of:

- Calculating rolling 7-day average sales
- Tracking inventory history using Snapshots (SCD Type 2)
- Estimating days of stock coverage
- Flagging products at risk of stockout
- Simulating replenishment needs for a target coverage level

---

## 🏗 Data Architecture

The project follows Analytics Engineering best practices:

### Layers:

- **Seeds (Raw)** → Simulated sales and inventory data
- **Staging** → Data cleaning and standardization
- **Snapshot** → Inventory history tracking (SCD Type 2)
- **Marts** → Business-ready analytical models

---

## 📊 Main Model: `fct_inventory_risk`

Grain:  
1 row per store, product, per day.

### Calculated Metrics:

- `avg_daily_consumption_7d` → Rolling average sales
- `days_of_stock` → Estimated stock coverage
- `is_stockout_risk` → Risk flag (≤ 3 days)
- `suggested_replenishment` → Suggested quantity to reach 7-day coverage

---

## 📈 Business Insights Generated

- Most critical products ranking
- Potential financial impact of stockouts
- Stores with highest exposure
- Intelligent replenishment simulation

---

## 🛠 Tech Stack

- dbt
- BigQuery
- SQL (CTEs, Window Functions)
- Snapshot (SCD Type 2)
- Git / GitHub

---

## 🚀 Technical Highlights

✔ Layered modeling architecture  
✔ Window Functions for temporal metrics  
✔ Historical inventory tracking via Snapshot  
✔ Business rule implementation  
✔ Strategic replenishment simulation  

---

## 📌 Key Learnings

This project strengthened skills in:

- Analytics Engineering
- Business-oriented data modeling
- Retail operational metrics
- dbt project organization and structure

---

## 👤 Author

Hélio da Silva Paiva Júnior  
Data Analyst / Analytics Engineer | SQL, Python, Power BI & Statistics

