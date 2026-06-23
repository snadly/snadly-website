# Personas

> **Internal reference.** Who each page is written for and why they care. All details are fictional but grounded in market reality.

---

## 1. Nadia — Head of BI

**Snapshot:** Nadia, 38. Head of BI at a $20M logistics company. 300 staff. 6-person BI team: 4 analysts, 1 analytics engineer, 1 data engineer. Revenue ~$67K/head.

**Current stack:** Snowflake, dbt Cloud, Fivetran, Looker. She already has a real data warehouse. Her team knows what best practice looks like — they just cannot afford the time to stay there.

**Weekly rhythm:** Every Monday, the ops director requests "one more dashboard." Her analytics engineer estimates 3 weeks. The bottleneck is always the staging-layer modelling for new source systems. Meanwhile, the marketing team has started building their own reports in Google Data Studio because BI is too slow. Numbers now disagree across the company. Documentation is 6 months behind. Tests are being skipped to hit deadlines. The warehouse is held together by one person's memory.

**Root pain:** Engineer capacity is the constraint, not business understanding. The backlog grows faster than the team. The pressure to ship means dbt best practice — tests, docs, lineage — slips further every month. Shadow BI creeps in because the business will not wait.

**What she's tried:** Hired a second analytics engineer. Takes 6 months to find and onboard. Consultant quotes are eye-watering and the output quality is unpredictable. Pitched a "governance freeze" to force documentation catch-up — the CFO laughed.

**Internal pressure:** The ops director is escalating to the CFO. "We pay for a BI team and I still can't see my numbers." Meanwhile, the marketing team's spreadsheets are becoming the de facto reporting layer. Her boss supports her but needs velocity to improve.

**Secret worry:** Her warehouse is one of the few things in the company that actually works — but it is slipping. She knows best practice is eroding under the backlog pressure. A tool that takes control of the codebase would be catastrophic, but she cannot keep going like this either.

**Governance concern:** If SNADLY is writing her ETL, who is in charge? Can her team modify models without SNADLY? What happens when the PR needs a change and SNADLY is not available? The contribution model needs to look like another team member, not a vendor that ships code and disappears.

**AI fear:** AI making unexpected changes to production pipelines. But the deeper fear: a tool that works until it does not. If her team cannot maintain the models independently, the tool becomes a dependency, not an accelerator. She trusts her engineers' PR reviews, not black boxes.

**What lands:** "Standard dbt PR raised against your repo. Your engineers review, test, and merge. You own every line. You can modify anything with or without SNADLY. SNADLY contributes like another team member — your governance, your codebase, your standards. Tests, documentation, and lineage with every model — whether you have them today or you are trying to get there."

**What scares her off:** A tool that takes control of the codebase. Models she cannot modify outside the platform. A vendor that ships code her team cannot maintain independently. Any suggestion that replaces her engineers or bypasses their review process.

**Cost anxiety:** Does the mental math on every pricing page she visits. $50/report-user × 300 staff = $15,000/month. Dead on arrival. She needs viewer-only pricing — the people who glance at dashboards and the people who build are different populations. Automated email reports and scheduled snapshots cannot count against seat costs.

**Decision authority:** Can approve a PoC on one source system without additional sign-off. A full rollout needs CFO approval, but a successful PoC gets her the budget conversation. If the per-user pricing maths out, she can get procurement sign-off.

**CTA path:** PoC on one real source system. The test is: "SNADLY raises a PR against a test repo with one of our source systems. My analytics engineer reviews it. If she would merge it, we have something."

---

## 2. Marcus — Solo Data Analyst

**Snapshot:** Marcus, 29. Only data person at a $5M DTC ecommerce brand. 30 staff. $167K rev/head. Reports to the Head of Growth.

**Current stack:** Shopify, Stripe, QuickBooks, Google Sheets. Exports CSVs from each source — none of these systems have proper databases or APIs he can use. His best tool is INDEX(MATCH) and pivot tables. He has heard of dbt, SQL, pull requests, and repos. They are wizard buzzwords. They sound like things big companies with IT departments use.

**Weekly rhythm:** Monday: export CSVs, join with INDEX(MATCH), clean, format, email the weekly report (3-4 hours). Tuesday: Head of Growth asks a follow-up — different joins needed. Marcus rebuilds Wednesday morning. Thursday: someone wants a metric from 6 months ago — he does not have it, exports only go back 90 days. Friday: catch up on ad-hoc requests. Zero analysis happened all week. He is a data reporter, not a data analyst.

**Root pain:** He spends his life rebuilding the same pipeline. Every report is a from-scratch Excel assembly. He has no queryable history, no single version of truth, and no way to answer a question without rebuilding the spreadsheet. But even thinking about fixing this feels overwhelming — setting up a warehouse sounds like a whole new job on top of the one he already cannot keep up with.

**What he's tried:** Pitched "we need a data warehouse" to the CEO. Got "how much, how long" and stalled — he did not have answers because he does not know himself. Opened a dbt getting-started guide — 40 steps, unfamiliar concepts, closed the tab. Tried a no-code BI tool — his source data is too messy and CSV-based; the tool assumes clean database connections.

**Setup fear:** Every tool he has looked at requires a setup project. He does not have time for a project. He needs something that produces value in the same afternoon he signs up — or it joins the graveyard of SaaS trials he has abandoned.

**Validation fear:** How does he know the output is right? His current workflow is slow but he trusts it because he built it. He can trace every number back to a CSV. If a tool generates models and numbers he cannot reconcile against his spreadsheet, he cannot defend it to the CEO. He needs to be able to spot-check: does this number match what my spreadsheet says for last Tuesday?

**Big business fear:** dbt, SQL, repos — he has seen these on LinkedIn and in job listings. They belong to companies with data teams. He is one person with Excel. He worries this category is not built for him and he will be out of his depth within 10 minutes.

**Internal pressure:** The CEO asks questions Marcus cannot answer quickly. "Which customer segment is actually growing?" He knows the answer is in the data somewhere, but extracting it will take a day. He feels like he is failing a test everyone assumes he should pass.

**Political reality:** Marcus is low on the corporate totem pole. He has never proposed a project in his life. He does not have the standing to champion a new platform purchase. If he recommends something and it fails, it has his name on it — and he does not have the political capital to absorb a visible failure. If it succeeds, his boss will probably present it to the CEO. He needs something that is safe to try: low commitment, no approval-chain drama, impossible to screw up in a way that embarrasses him.

**Secret worry:** He built the whole reporting system himself. If he leaves, there is no system — just his files. Also: he is embarrassed by the Excel workflow. He knows what a real data stack looks like from LinkedIn and feels a decade behind. But he is also afraid that "real" tools will be too complex for his reality.

**AI fear:** "AI wrote it" means "I cannot verify it." He has seen AI hallucinate numbers. If he cannot inspect the logic — in terms he understands — he cannot trust the output, and he is the one who has to defend it to the CEO. But the deeper fear: AI that produces SQL he cannot read at all. He needs to see the logic and recognise it.

**What lands:** "Upload your CSV. SNADLY generates the warehouse. Spot-check it against your spreadsheet — the numbers should match. Here is the SQL that built your customer summary — it is your INDEX(MATCH) logic, written as a query you can read and learn from. No setup project. No approval needed. Working in the same afternoon. If it works, you have something to show. If it does not, you lost an afternoon and nobody needs to know."

**What scares him off:** A setup wizard with 12 steps. Jargon he has to Google. Output he cannot reconcile against his existing numbers. Pricing that requires CEO approval — he has a company card, not a procurement process. Anything with his name on it that could blow up in front of his boss.

**Decision authority:** Company credit card. Can put through <$500/month without approval. Anything above needs CEO sign-off, which means "a meeting" and possibly "a deck."

**CTA path:** Self-serve signup or free tier. Upload a CSV, get a working model, spot-check the numbers against his spreadsheet. If he can do this in under 30 minutes and the numbers reconcile, he is in.

---

## 3. Priya — Owner-Operator

**Snapshot:** Priya, 44. Owner and managing director of a food importing and distribution business. $800K revenue, 8 staff. $100K rev/head. She runs finance, operations, supplier relationships, and customer accounts. No IT beyond a part-time MSP who handles email and the WiFi.

**Current stack:** Xero for accounting. Everything else is spreadsheets and her head. Stock orders in one sheet. Invoices in another. Customer contacts in a third. Google AdWords conversion data that someone set up in a shared spreadsheet two years ago and nobody remembers who owns it. Bank balance in Xero but always 2 days behind. She holds the complete picture in her head — and on several scraps of paper on her desk.

**Data reality:** Half her business data has no proper system. It lives in spreadsheets she and her staff update manually. Some of it is just numbers she knows. When someone asks "how did we do on that ad campaign," the answer requires opening three spreadsheets and doing mental arithmetic. She does not have clean APIs or database connections. She has CSV exports and Google Sheets. Will any tool even work with what she has?

**Weekly rhythm:** Monday: chase overdue invoices, check bank balance, reorder stock that "feels" low because she does not have a live inventory view. Tuesday: realise she ordered the wrong quantity — she was guessing. Wednesday: a supplier calls about a payment she thought went through. She opens Xero to check — the report she wants does not exist. She cannot build her own report in Xero. She squints at the pre-canned dashboard and does mental arithmetic. Thursday: sit down to review the month — gives up because numbers across systems do not tie. Friday: place orders, hope for the best.

**Root pain:** She makes decisions from partial pictures. She knows this. Xero's reports are pre-canned — she cannot ask her own questions. Her spreadsheet data does not talk to her accounting data. She does not know which products make money, which customers are worth keeping, or whether she can afford the next order. The data exists — scattered across tools, spreadsheets, and her head — but nobody has put it together, and the tools that claim to do this assume she has systems she does not have.

**What she's tried:** Asked the MSP if they can "make the systems talk to each other." Got quoted $15K and a project timeline. She laughed. Tried a dashboard tool — it asked her to "connect data sources" and she closed the tab. The whole category assumes she has an IT department and proper databases. She has neither.

**Internal pressure:** Cash stress. A supplier tightens payment terms and she does not know if she can absorb it. A slow month and she does not spot it until the bank account is thin. She needs to know what is happening *now*, not what the accountant tells her in three months. She wants to ask questions of her own business and get answers without waiting for someone else to build a report.

**Secret worry:** She has been running this business for 8 years and still makes decisions by gut. She is not sure the business would survive her taking 3 weeks off. There is no system — just her. And she is afraid that "real" business tools require "real" business infrastructure, which she does not have and cannot afford to build.

**AI fear:** She does not understand AI and does not want to. "AI" sounds like a thing that makes decisions she cannot explain. She needs to trust whatever she is looking at — if she cannot understand how the number got there, she will not use it. The numbers need to match the reality she knows from running the business every day.

**What lands:** "Upload your spreadsheets and connect Xero. SNADLY is an AI report builder — it writes the reports you wish Xero gave you. You can click on any number and see exactly where it came from: that cell in your stock sheet, that line in Xero from Tuesday. Every report is automatically checked for sanity before you see it — if a number looks wrong, it gets flagged before it reaches you. No jargon. No setup project. You will recognise every number because they come from your own spreadsheets and your own Xero account."

**What scares her off:** The words "data pipeline," "ETL," "schema," "data warehouse," "seats," or "per-user pricing." Anything that requires her to configure something. A tool that tells her to "connect your data sources" and shows her a blank screen with 12 connector logos. Anything that assumes her business runs on Salesforce and Stripe. A price that sounds like it belongs to a company with 300 employees.

**Decision authority:** Sole decision-maker. Will spend if the price is clear and the value is obvious. No committees, no procurement — if she trusts it and it is affordable, she buys it. The threshold is "does this cost less than the mistakes I make from not having it."

**CTA path:** Guided onboarding. Someone walks her through uploading her main spreadsheets and connecting Xero. She sees her numbers — her real numbers, from her real data — on a screen within that session. She will not self-serve. She will not configure anything.

---

## 4. Tom — BI Consultancy Partner

**Snapshot:** Tom, 46. Partner and Head of Delivery at a $5.5M BI consultancy. 22 staff: 8 data engineers, 4 BI developers, plus PMs and sales. $250K rev/head. They deliver end-to-end warehouse projects for mid-market clients. Typical engagement: 3-6 months, $80-150K.

**Current stack:** dbt Cloud, Snowflake, Power BI, Tableau — whichever stack the client uses. His team has a house style for modelling, naming, testing, and documentation. Every project starts the same way: source-system interpretation, staging models, initial marts.

**Weekly rhythm:** Monday: review 3 active project plans. Every one is behind on the "build" phase because the initial modelling soaked up more time than estimated. Tuesday: a senior engineer complains she spent 4 days modelling a Shopify schema that's identical to the last 3 Shopify projects. Wednesday: a junior consultant freezes in a client walkthrough — the client asks why a staging column was renamed and the junior can't explain the logic. Tom's senior engineer has to step in. Thursday: Tom reviews the pipeline — 7 qualified leads, capacity for maybe 2 more projects without hiring. He can only grow by hiring juniors, but juniors create client risk. Friday: interviews yet another data engineer. Hiring is brutal.

**Root pain:** His team's most expensive people spend too much time on repeatable build work. The initial modelling phase doesn't differentiate his firm — every consultancy does it. The part clients actually pay for (metric definitions, business interpretation, dashboards, adoption) gets compressed because the build phase ate the budget. Meanwhile, the only way to scale is to hire juniors — and juniors in front of clients is where things break.

**What he's tried:** Built internal scaffolding scripts for common source systems. Helped, but fragile — each client has variations. Tried hiring junior engineers to do the grunt work — training overhead ate the margin savings and the client-facing risk went up. Considered an offshore team — quality inconsistency made his senior people do rework.

**Internal pressure:** He wants 10x the project volume with 2x the staff. Not by hiring — by making the existing team more leveraged. He doesn't want to fire anyone. He wants the same people doing higher-value work and running more projects in parallel. But every growth path introduces client-facing risk through less experienced hands.

**Secret worry:** He walks into a client meeting and the junior consultant who built the staging layer can't answer a basic question about a transformation. The client loses confidence. The engagement goes sideways. Also: a competitor will figure out how to deliver faster without the junior risk. Some well-funded startup is going to automate the modelling phase, and the consultancies that don't adapt will get squeezed on price while still carrying high salary costs.

**AI fear:** He's heard every AI pitch in the last 2 years. Most produce plausible-looking models that fall apart under scrutiny. His team would spend more time fixing bad generated code than writing it from scratch. But the deeper fear: AI amplifies the junior risk. If a junior doesn't understand the code they wrote, they're in trouble. If they don't understand AI-generated code — code nobody wrote — they're completely exposed. A consultant standing in front of a client with generated models they can't explain or defend is a liability.

**What lands:** "Your consultants walk into client meetings with deeper mastery of the warehouse than if they'd built it from scratch. Every transformation is standard dbt SQL, fully documented with assumptions and lineage. Your team reviews and owns every model. The training and review flow means your least experienced consultant can explain the staging logic to a skeptical technical stakeholder. No SNADLY branding. Your delivery, your name, your client relationship."

**What scares him off:** Any output his juniors can't explain in front of a client. Vendor branding. Models he can't style to his house conventions. A tool that makes his team weaker, not stronger. Per-client pricing that kills his margin.

**Decision authority:** Can approve a trial on a recent project shape without partner consensus. Full adoption would need the other partner on board, but he's the delivery lead — his recommendation carries weight.

**CTA path:** Partner conversation. Trial on a past project: "Here's a recent Shopify-to-Snowflake project — can SNADLY produce the staging and marts my team would have built?" If yes, pilot on a live client with a fixed-scope retainer.
