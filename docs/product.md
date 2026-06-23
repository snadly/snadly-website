# SNADLY — product definition

> **Internal reference.** What SNADLY actually does and how it works. For anyone writing or editing site copy.

---

## What SNADLY does

1. **Connect sources** — Shopify, Stripe, HubSpot, QuickBooks, and other operational systems
2. **AI writes real dbt models** — staging, intermediate, and mart layers with tests, documentation, and lineage. The output is standard dbt SQL. No AI at runtime.
3. **Provisions the stack** — for clients without a data warehouse, SNADLY sets up Snowflake and dbt Core
4. **Generates basic JS dashboards** — lightweight visuals running directly against the warehouse

The generated data warehouse is the product. The dashboards are optional.

---

## What SNADLY is not

- **Not a dashboarding tool.** Dashboards are basic JS, not a full BI platform.
- **Not a black box.** The dbt project is standard, inspectable, and portable. Any data engineer can pick it up, modify it, and keep using their own tools.
- **Not Tableau.** Tableau is a visual analytics layer. SNADLY generates the warehouse and models that sit underneath. The output can feed Tableau (or any other BI tool), but SNADLY itself is not trying to be one.
- **Not a one-time ETL.** The models are re-runnable. They're real transformations, not an import snapshot.

---

## How it works

1. User connects source systems
2. SNADLY interprets source schemas and generates:
   - Staging models (raw source tables, lightly cleaned)
   - Intermediate models (business logic, joins, aggregations)
   - Marts (reporting-ready dimensional and fact tables)
   - Tests (data quality assertions)
   - Documentation (column descriptions, lineage, assumptions)
3. If the client does not have a warehouse, SNADLY provisions Snowflake and dbt Core
4. Basic JS dashboards are generated on top for quick visibility
5. The full dbt project is delivered — client can run, inspect, extend, or hand off

---

## Time claim

**"Minutes, not weeks."** After source connection, the first useful output (staging models, basic marts, a dashboard) is available in minutes. This covers the repeatable build work that normally consumes the first stretch of a warehouse project.

---

## Stack reference

| Layer | Technology | Notes |
|---|---|---|
| Warehouse | Snowflake | Provisioned by SNADLY if client has none |
| Transformation | dbt Core | Standard dbt project, no proprietary format |
| Dashboards | Basic JS | Lightweight, generated, not a BI suite |
| AI | Used at generation time only | No AI in running models or dashboards |

---

## Copy guardrails

- **"dbt" is safe to mention** in technical pages (BI teams, consultancies). Avoid on the business-owner page.
- **"Snowflake" is safe to mention** in technical pages. Not needed on owner or analyst pages — the value is the warehouse existing, not the brand.
- **"AI" is accurate** for how the models are written, but never imply AI is running live on the data. "AI-generated models" is fine. "AI-powered analytics" is misleading.
- **"Models" and "warehouse" over "platform."** SNADLY is not a SaaS dashboard. It's a warehouse generator.
- **The dashboards are basic.** Don't oversell them. The warehouse is the durable thing.
