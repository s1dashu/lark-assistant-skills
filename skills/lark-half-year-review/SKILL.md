---
name: lark-half-year-review
description: Generate a half-year Lark/Feishu work review. Use when the user asks for 半年总结, H1 review, H2 review, 半年度复盘, or /半年总结.
---

# Lark Half-Year Review

Generate a half-year review focused on strategic outcomes, capability growth, major decisions, recurring risks, and next-half direction. This should be sharper than an annual review and more strategic than a monthly report.

Chinese aliases: `/半年总结`, `半年复盘`, `上半年总结`, `下半年总结`.

## Common Preconditions

- Use `--as user` for personal work context unless the user explicitly requests bot-owned resources.
- If `~/.lark-assistant.json` exists, read it first and obey configured privacy boundaries, source scope, output destinations, report style, and notification policy.
- If this collection is installed as a whole, follow `../lark-assistant-skills/references/common/config-schema.md` and `../lark-assistant-skills/references/common/reporting-standards.md` for shared configuration, source-scope, calendar, task, synthesis, and safety guidance. This skill remains usable without those references.
- Resolve all dates in the machine's local timezone. Use system date/time commands for relative ranges such as H1, H2, 上半年, 下半年, and 近半年.
- Do not use Markdown tables in final output; Lark IM and some Lark Markdown renderers handle tables poorly. Use numbered or bulleted lists.
- Ask before saving, sending, creating, updating, or deleting any Lark resource.
- If a source is unavailable because of permissions, privacy rules, or missing identifiers, skip it and state the gap.

## Window

Resolve H1 as January 1 to June 30, and H2 as July 1 to December 31. If the current half-year is incomplete, end at now and label it as a half-year-to-date review.

If the user says "近半年", use the last six calendar months ending today unless they clearly mean H1/H2.

## Data Collection

Strict rule: document-first and milestone-first. Do not fetch raw daily data exhaustively. A half-year review should summarize durable outcomes, mid-cycle course corrections, risks, and the next half's operating plan.

### Step 1: Configuration And Existing Reports

```bash
test -f ~/.lark-assistant.json && sed -n '1,220p' ~/.lark-assistant.json
```

Search for existing monthly, weekly, half-year, quarterly, review, and planning docs:

```bash
lark-cli docs +search --as user --query "半年总结 月报 周报 季度总结 复盘 规划 绩效" --format json --page-size 25
lark-cli docs +search --as user --query "<major_project_or_goal>" --format json --page-size 15
```

Fetch only the most relevant docs: user-authored, updated during the period, linked from milestone meetings, or repeatedly surfaced across searches.

### Step 2: Monthly/Milestone Meeting Scan

Search month by month or by quarter within the half-year:

```bash
lark-cli vc +search --as user --query "复盘 规划 review 评审 发布 上线 决策 阻塞 事故" --start "<month_start_date>" --end "<month_end_date>" --format json --page-size 30
```

If the JSON response contains `has_more` or `page_token`, continue pagination until that month or quarter is covered, unless the user asked for a quick draft.

Fetch meeting notes only when:

- The user organized/drove the meeting.
- The meeting title indicates a review, launch, decision, incident, commercial milestone, architecture change, or project planning.
- The meeting connects to a major project from docs/tasks.

### Step 3: Task And OKR Signals

Use tasks to find major completed milestones, overdue commitments, and cross-half carryover:

```bash
lark-cli task +get-my-tasks --as user --created_at "<period_start_iso>" --format json --page-all
lark-cli task +get-my-tasks --as user --due-start "<period_start_iso>" --due-end "<period_end_iso>" --format json --page-all
```

Use OKR only if authorized, explicitly requested, or configured as enabled:

```bash
lark-cli okr +cycle-list --as user
lark-cli okr +cycle-detail --as user --cycle-id "<id>"
```

If OKR needs a user id or scope, skip and state the gap.

### Step 4: Optional Targeted Context

Use mail or IM only for named projects, external collaborations, unresolved commitments, or leadership-visible issues. Do not broad-scrape six months of messages.

## Synthesis Rules

- Identify 3-5 major workstreams and explain how each evolved across the half-year.
- Separate `主导负责`, `核心推进`, `重要协作`, and `旁听/了解`.
- Emphasize mid-cycle course correction: what changed, what was abandoned, what became higher priority.
- Summarize durable outcomes and reusable methods, not activity volume.
- Include cross-half carryover: work that must continue into the next half.
- State missing month/project data naturally in the relevant section only when it affects the review, such as "未找到 5 月相关总结" or "无权限访问某项目文档".
- Do not inflate passive meeting attendance into contribution.
- Write like a human performance review: use cohesive paragraphs for judgment and ordered lists for evidence. Avoid generic Markdown bullet dumps.

## Evidence And Confidence Rules

For every major workstream, include:

- Main evidence sources.
- Ownership level.
- Outcome or current state.
- Remaining risk or next-half implication.
- Confidence label: 高 / 中 / 低.

Use `低可信` for claims based only on sparse meeting titles or task names.

## Quality Bar

The half-year review should answer:

1. What were the 3-5 main workstreams?
2. Which outcomes are durable enough to mention in performance review?
3. What changed during the half-year?
4. What risks or debts carry into the next half?
5. What should be prioritized, reduced, or delegated next half?

## Output

```md
# 半年工作总结（[Start] - [End]）

## 半年总览
用 1-2 个自然段总结半年主线、关键成果、主要转折和是否为 half-year-to-date。

## 主导核心成果与影响
### [Theme/Project]
1. **角色定位**: 主导负责 / 核心推进 / 重要协作
2. **阶段成果**: [用完整句说明成果]
3. **影响范围**: [用完整句说明影响]
4. **关键证据**: [Source type + title/date/link/id]
5. **可信度**: 高 / 中 / 低
6. **下半阶段影响**: ...

## 重要协作与组织贡献
1. ...

## 半年内的关键转折
1. **[Month/Decision]**: [What changed, why it mattered, evidence]

## 能力成长与方法沉淀
1. **[Capability/Method]**: [Evidence-backed improvement or reusable practice]

## 遗留问题与系统性风险
用 1 个自然段说明遗留问题、系统性风险和原因。

## 下半阶段建议方向
1. **继续加码**: ...
2. **需要收敛**: ...
3. **应建立的机制**: ...
4. **需要提前对齐的人/团队**: ...
```

Ask before writing or sending the review.
