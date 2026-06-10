# Personas

> **Internal reference.** Who each page is written for and why they care. All details are fictional but grounded in market reality.

---

## 1. Nadia — Head of BI

**Snapshot:** Nadia, 38. Head of BI at a $20M logistics company. 300 staff. 6-person BI team: 4 analysts, 1 analytics engineer, 1 data engineer. Revenue ~$67K/head.

**Current stack:** Snowflake, dbt Cloud, Fivetran, Looker. She already has a real data warehouse and governed pipelines. Her team knows what good looks like.

**Weekly rhythm:** Every Monday, the ops director requests "one more dashboard." Her analytics engineer estimates 3 weeks. The bottleneck is always the staging-layer modelling for new source systems. The team can only ship as fast as the engineer can model.

**Root pain:** Engineer capacity is the constraint, not business understanding. The backlog grows faster than the team. Every request has days or weeks of repeatable plumbing before anyone touches the part that requires judgement.

**What she's tried:** Hired a second analytics engineer. Takes 6 months to find and onboard. Consultant quotes are eye-watering and the output quality is unpredictable. She's considered running an intern experiment — too risky for governed infra.

**Internal pressure:** The ops director is escalating to the CFO. "We pay for a BI team and I still can't see my numbers." Her boss supports her but needs velocity to improve.

**Secret worry:** Her warehouse is one of the few things in the company that actually works reliably. She will not risk breaking it for speed. If a tool introduces changes her engineers can't inspect, audit, and roll back, she'll veto it herself.

**AI fear:** AI makes unexpected changes, introduces noise, breaks governed pipelines. An engineer reviews every PR — she trusts humans, not black boxes.

**What lands:** "Standard dbt SQL. No AI at runtime. Your engineers review and own every model. It's just generated starting-point code — governance stays with your team."

**What scares her off:** Any suggestion that Kilo replaces her engineers, bypasses her review process, or runs live AI on production data.

**Decision authority:** Can approve a PoC on one source system without additional sign-off. A full rollout needs CFO approval, but a successful PoC gets her the budget conversation.

**CTA path:** PoC on one real source system. The test is: "Does my analytics engineer respect the generated models and can my analysts build dashboards on them?"

---

## 2. Marcus — Solo Data Analyst

**Snapshot:** Marcus, 29. Only data person at a $5M DTC ecommerce brand. 30 staff. $167K rev/head. Reports to the Head of Growth.

**Current stack:** Shopify, Stripe, QuickBooks, Google Sheets. Exports CSVs from each source. Joins, cleans, formats in Excel. Everything lives in his spreadsheets and his head.

**Weekly rhythm:** Monday: export, join, clean, format, email the weekly report (3-4 hours). Tuesday: Head of Growth asks a follow-up — different joins needed. Marcus rebuilds Wednesday morning. Thursday: someone wants a metric from 6 months ago — he doesn't have it, export pipeline only goes back 90 days. Friday: catch up on ad-hoc requests. Zero analysis happened all week. He is a data reporter, not a data analyst.

**Root pain:** He spends his life rebuilding the same pipeline. Every report is a from-scratch Excel assembly. He has no queryable history, no single version of truth, and no way to answer a question without rebuilding the spreadsheet.

**What he's tried:** Pitched "we need a data warehouse" to the CEO. Got "how much, how long" and stalled. Opened a dbt getting-started guide — 40 steps, unfamiliar concepts, closed the tab. Tried a no-code BI tool — his source data is too messy, the tool assumes clean inputs.

**Internal pressure:** The CEO asks questions Marcus can't answer quickly. "Which customer segment is actually growing?" He knows the answer is in the data somewhere, but extracting it will take a day. He feels like he's failing a test everyone assumes he should pass.

**Secret worry:** He built the whole reporting system himself. If he leaves, there is no system — just his files. Also: he's embarrassed by the Excel workflow. He knows what a real data stack looks like from LinkedIn and feels a decade behind.

**AI fear:** "AI wrote it" means "I can't verify it." He's seen AI hallucinate numbers. If he can't inspect the logic, he can't trust the output, and he's the one who has to defend it to the CEO.

**What lands:** "Real SQL you can inspect. It's your Excel logic, but in dbt. You can read every line of the transformation. Here — this is the SELECT statement that built your customer summary. You can check it, change it, learn from it."

**What scares him off:** Black-box outputs he can't verify. Pricing that requires approval — he has a company card with a soft limit, not a procurement process.

**Decision authority:** Company credit card. Can put through <$500/month without approval. Anything above needs CEO sign-off, which means "a meeting" and possibly "a deck."

**CTA path:** Self-serve signup or free tier. Quick first run on Stripe or Shopify data. If he can generate a working model and see his own numbers in under 30 minutes, he's in.

---

## 3. Priya — Owner-Operator

**Snapshot:** Priya, 44. Owner and managing director of a food importing and distribution business. $800K revenue, 8 staff. $100K rev/head. She runs finance, operations, supplier relationships, and customer accounts. No IT beyond a part-time MSP who handles email and the WiFi.

**Current stack:** Xero for accounting, spreadsheets for everything else. Stock orders in one sheet. Invoices in another. Bank balance in Xero but it's always 2 days behind. She holds the entire picture in her head and on a few scraps of paper on her desk.

**Weekly rhythm:** Monday: chase overdue invoices, check bank balance, reorder stock that "feels" low. Tuesday: realize she ordered the wrong quantity because she was guessing. Wednesday: a supplier calls asking about a payment she thought went through. Thursday: sit down to review the month — gives up because the numbers don't tie together. Friday: place orders, hope for the best.

**Root pain:** She makes decisions from partial pictures. She knows this. She doesn't know which products make money, which customers are worth keeping, or whether she can afford the next order. The data exists across her tools — it just doesn't agree and nobody has put it together.

**What she's tried:** Asked the MSP if they can "make the systems talk to each other." Got quoted $15K and a project timeline. She laughed. Tried a dashboard tool — it asked her to "connect data sources" and she closed the tab. The whole category assumes she has an IT department.

**Internal pressure:** Cash stress. A supplier tightens payment terms and she doesn't know if she can absorb it. A slow month and she doesn't spot it until the bank account is thin. She needs to know what's happening *now*, not what the accountant tells her in three months.

**Secret worry:** She's been running this business for 8 years and still makes decisions by gut. She's not sure the business would survive her taking 3 weeks off. There is no system — just her.

**AI fear:** She doesn't understand AI and doesn't want to. "AI" sounds like a thing that makes decisions she can't explain. She needs to trust whatever she's looking at — if she can't understand how the number got there, she won't use it.

**What lands:** "No AI in the running numbers. Just a warehouse with your real data. Here — this number is your cash position this morning. This one is your margin per product line. These five numbers update when your systems update. That's it."

**What scares her off:** Jargon, configuration, "set up your data pipeline," "connect your ETL," monthly seats, per-user pricing, anything that requires her to learn what a schema is.

**Decision authority:** Sole decision-maker. Will spend if the price is clear and the value is obvious. No committees, no procurement — if she trusts it and it's affordable, she buys it.

**CTA path:** Guided onboarding. Someone walks her through connecting Xero and her main operational system. She sees the numbers on a screen within that session. She will not self-serve.

---

## 4. Tom — BI Consultancy Partner

**Snapshot:** Tom, 46. Partner and Head of Delivery at a $5.5M BI consultancy. 22 staff: 8 data engineers, 4 BI developers, plus PMs and sales. $250K rev/head. They deliver end-to-end warehouse projects for mid-market clients. Typical engagement: 3-6 months, $80-150K.

**Current stack:** dbt Cloud, Snowflake, Power BI, Tableau — whichever stack the client uses. His team has a house style for modelling, naming, testing, and documentation. Every project starts the same way: source-system interpretation, staging models, initial marts.

**Weekly rhythm:** Monday: review 3 active project plans. Every one is behind on the "build" phase because the initial modelling soaked up more time than estimated. Tuesday: a senior engineer complains she spent 4 days modelling a Shopify schema that's basically identical to the last 3 Shopify projects. Wednesday: client asks for a change order because the scope underestimated the staging work. Thursday: Tom reviews the pipeline — 7 qualified leads, capacity for maybe 2 more projects without hiring. Friday: interviews yet another data engineer. Hiring is brutal.

**Root pain:** His team's most expensive people spend too much time on repeatable build work. The initial modelling phase doesn't differentiate his firm — every consultancy does it. The part clients actually pay for (metric definitions, business interpretation, dashboards, adoption) gets compressed because the build phase ate the budget.

**What he's tried:** Built internal scaffolding scripts for common source systems. Helped, but fragile — each client has variations. Tried hiring junior engineers to do the grunt work — training overhead ate the margin savings. Considered an offshore team — quality inconsistency made his senior people do rework.

**Internal pressure:** He wants 10x the project volume with 2x the staff. Not by hiring — by making the existing team more leveraged. He doesn't want to fire anyone. He wants the same people doing higher-value work and running more projects in parallel.

**Secret worry:** A competitor will figure this out first. Some well-funded startup is going to automate the modelling phase, and the consultancies that don't adapt will get squeezed on price while still carrying high salary costs. Also: his senior people are burning out doing work they're overqualified for.

**AI fear:** He's heard every AI pitch in the last 2 years. Most produce plausible-looking models that fall apart under scrutiny. His team would spend more time fixing bad generated code than writing it from scratch. If the output isn't reviewable and defensible, it's worse than worthless — it erodes client trust.

**What lands:** "Generated dbt project in your house style. Your team reviews every model. Training and review flow built in — they'll understand the output deeply and defend it to clients. No Kilo branding. Your delivery, your name, your client relationship. The generated work is standard dbt code — the same thing your engineers would write, just faster."

**What scares him off:** Any output that carries vendor branding, cannot be styled to his conventions, or produces models his team can't explain. White-label is non-negotiable. Also: per-client pricing that kills his margin.

**Decision authority:** Can approve a trial on a recent project shape without partner consensus. Full adoption would need the other partner on board, but he's the delivery lead — his recommendation carries weight.

**CTA path:** Partner conversation. Trial on a past project: "Here's a recent Shopify-to-Snowflake project — can Kilo produce the staging and marts my team would have built?" If yes, pilot on a live client with a fixed-scope retainer.
