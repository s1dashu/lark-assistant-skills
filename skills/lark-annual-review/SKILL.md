---
name: lark-annual-review
description: Generate an annual Lark/Feishu work review. Use when the user asks for 年终总结, 全年总结, annual review, 年度复盘, or /年终总结.
---

# Lark Annual Review

Generate an annual review for performance, promotion, reflection, or strategic planning. This is not a longer monthly report; it must synthesize the year's trajectory, durable outcomes, scope of impact, capability growth, and strategic lessons.

Chinese aliases: `/全年总结`, `/年终总结`, `年度总结`, `年度复盘`.

## Common Preconditions

- Use `--as user` for personal work context unless the user explicitly requests bot-owned resources.
- If `~/.lark-assistant.json` exists, read it first and obey configured privacy boundaries, source scope, output destinations, report style, and notification policy.
- If this collection is installed as a whole, follow `../lark-assistant-skills/references/common/config-schema.md` and `../lark-assistant-skills/references/common/reporting-standards.md` for shared configuration, source-scope, calendar, task, synthesis, and safety guidance. This skill remains usable without those references.
- Resolve all dates in the machine's local timezone. Use system date/time commands for relative ranges instead of mental calculation.
- Do not use Markdown tables in final output; Lark IM and some Lark Markdown renderers handle tables poorly. Use numbered or bulleted lists.
- Ask before saving, sending, creating, updating, or deleting any Lark resource.
- If a source is unavailable because of permissions, privacy rules, or missing identifiers, skip it and state the gap.

## Window

Default to January 1 through December 31 of the requested year. If the current year is incomplete, end at now and clearly label it as a year-to-date review.

When the user asks for "今年", use the current local year. When they ask for "去年", use the previous local calendar year.

## Data Collection

Strict rule: aggregate first. Do not fetch raw daily tasks, raw IM history, or raw mail exhaustively. Annual reviews are high-stakes, so prefer existing summaries, performance docs, OKRs, milestone meetings, major project docs, and decision records.

### Step 1: Configuration And Existing Summaries

First check whether the user has configured source scope and output style:

```bash
test -f ~/.lark-assistant.json && sed -n '1,220p' ~/.lark-assistant.json
```

Search for existing annual, half-year, quarterly, monthly, weekly, review, promotion, and performance docs:

```bash
lark-cli docs +search --as user --query "年终总结 年度总结 半年总结 季度总结 月报 周报 复盘 晋升 绩效" --format json --page-size 30
lark-cli docs +search --as user --query "<major_project_or_goal>" --format json --page-size 20
```

Fetch full document content only for the 3-8 most relevant docs. Prefer docs that are authored by the user, recently updated, linked from meetings, or repeatedly referenced across search results.

### Step 2: Milestone Meetings By Quarter

Search by quarter to avoid missing pagination and to reduce noisy result sets:

```bash
lark-cli vc +search --as user --query "复盘 规划 review 评审 发布 上线 决策 milestone" --start "<q_start_date>" --end "<q_end_date>" --format json --page-size 30
```

If the JSON response contains `has_more` or `page_token`, continue pagination until the quarter is covered, unless the user asked for a quick draft.

Fetch notes only for meetings that satisfy at least one condition:

- The user organized the meeting or appears as an explicit owner.
- The title contains review, launch, release, decision, incident, planning, budget, commercial, architecture, strategy, or other milestone words.
- The meeting recurs across multiple quarters or links to major docs.
- The meeting is directly tied to a project already identified from docs/tasks/OKRs.

### Step 3: Task And OKR Signals

Use tasks to validate delivery and unfinished commitments, not to list daily activity:

```bash
lark-cli task +get-my-tasks --as user --created_at "<year_start_iso>" --format json --page-all
lark-cli task +get-my-tasks --as user --due-start "<year_start_iso>" --due-end "<year_end_iso>" --format json --page-all
```

Only fetch OKR if authorized, explicitly requested, or configured as an enabled source:

```bash
lark-cli okr +cycle-list --as user
lark-cli okr +cycle-detail --as user --cycle-id "<id>"
```

If OKR commands need user id or permissions, do not block the review; record the gap.

### Step 4: Optional Targeted Context

Use mail or IM only for specific projects, external collaborations, unresolved commitments, or leadership-visible incidents. Never broad-scrape a full year of messages.

## Synthesis Rules

- Build from aggregates, then validate with milestone evidence.
- Organize around 3-6 durable outcome areas, not months.
- For each outcome area, state result, impact, evidence, ownership level, and remaining risk.
- Separate `主导负责`, `核心推进`, `重要协作`, and `旁听/了解`. Do not inflate passive attendance.
- Extract major decisions and what changed because of them.
- Include a quarter-by-quarter trajectory section to show evolution, gaps, and discontinuities.
- If a project disappears from the data after Q2, explicitly state "无 Q3/Q4 进展数据" instead of fabricating continuity.
- Use performance-review language when appropriate: impact scope, measurable result, cross-team leverage, complexity handled, and reusable methods.
- Keep emotional or subjective claims out unless directly supported by evidence.
- Write like a human annual review: use cohesive paragraphs for judgment and ordered lists for evidence. Avoid generic Markdown bullet dumps.

## Evidence And Confidence Rules

For every major claim, attach at least one evidence type:

- Lark Doc or Wiki title/link
- Meeting title/date or VC note
- Task title/status/due date
- OKR objective/key result
- Mail/IM thread only when explicitly used

Use confidence labels:

- **高可信**: supported by docs plus meetings/tasks/OKR.
- **中可信**: supported by one strong source or multiple weak metadata sources.
- **低可信**: inferred from sparse metadata; present as hypothesis.

## Quality Bar

The annual review should answer:

1. What changed because of the user's work this year?
2. Which outcomes were personally led versus supported?
3. Which decisions or pivots mattered most?
4. What work system or capability improved?
5. What risks, debts, or repeated patterns remain?
6. What should the user focus on next year?

## Output

```md
# 年度工作总结（[Year]）

## 年度总览
用 1-2 个自然段总结年度轨迹、成果范围、关键变化和是否为 year-to-date。

## 核心成果与影响
### [Outcome Area]
1. **角色定位**: 主导负责 / 核心推进 / 重要协作
2. **结果**: [用完整句说明结果]
3. **影响范围**: [用完整句说明影响]
4. **关键证据**: [Source type + title/date/link/id]
5. **可信度**: 高 / 中 / 低
6. **遗留问题**: ...

## 季度轨迹回顾
### Q1
1. **主线**: ...
2. **关键进展/决策**: ...
3. **数据缺口**: ...

### Q2
- ...

### Q3
- ...

### Q4
- ...

## 关键决策与转折
1. **[Decision]**: [Context, decision, consequence, evidence]

## 组织协作与影响力
用 1 个自然段说明组织协作、跨团队影响力和可验证结果。

## 能力成长与方法论沉淀
1. **[Capability/Method]**: [Evidence-backed change in how the user works]

## 问题、风险与反思
用 1 个自然段说明问题、风险、反思和原因。

## 下一年度建议方向
1. **战略重点**: ...
2. **应该停止/减少**: ...
3. **应该建立的机制**: ...
```

Ask before saving or sharing the review.
