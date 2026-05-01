---
name: lark-assistant-skills
description: Unified skill for Lark/Feishu personal assistant workflows. Use for daily/weekly/monthly reports, planning, meeting briefs, project summaries, mailbox triage, work diagnosis, and knowledge capture. Chinese aliases include /日报, /周报, /月报, /今日规划, /本周规划, /工作诊断, /项目总结, /会前简报, /会议纪要, /邮箱检查, /知识沉淀.
---

# Lark Assistant Skills

Unified skill collection for Lark/Feishu personal assistant workflows.

## How to Use

Invoke a specific workflow by name. Each workflow below points to the shared references in `references/common/` for data collection, synthesis, and safety rules.

## Commands

### Setup
- `/lark-setup` — Initialize data-source scope, privacy boundaries, output destinations, and notification policy.

### Reports
- `/lark-daily-report` — Daily report. Alias: `/日报`, `生成日报`, `今日工作总结`, `昨天日报`.
- `/lark-weekly-report` — Weekly report. Alias: `/周报`, `生成周报`, `本周总结`, `上周周报`.
- `/lark-monthly-report` — Monthly report. Alias: `/月报`, `生成月报`, `本月总结`.
- `/lark-half-year-review` — Half-year review. Alias: `/半年总结`, `年中总结`.
- `/lark-annual-review` — Annual review. Alias: `/全年总结`, `/年终总结`.
- `/lark-okr-review` — OKR progress and alignment review. Alias: `/OKR复盘`.

### Planning
- `/lark-today-plan` — Today's plan. Alias: `/今日规划`, `今天做什么`.
- `/lark-tomorrow-plan` — Tomorrow's plan. Alias: `/明日规划`, `明天做什么`.
- `/lark-weekly-plan` — Weekly plan. Alias: `/本周规划`, `下周规划`.
- `/lark-monthly-plan` — Monthly plan. Alias: `/本月规划`, `下月规划`.

### Assistant Workflows
- `/lark-meeting-brief` — Pre-meeting briefing. Alias: `/会前简报`, `/会议准备`.
- `/lark-meeting-minutes` — Single-meeting minutes and follow-up extraction. Alias: `/会议纪要`.
- `/lark-project-summary` — Project summary. Alias: `/项目总结`, `/项目回顾`.
- `/lark-mail-check` — Mailbox triage. Alias: `/邮箱检查`, `/邮件检查`.
- `/lark-knowledge-capture` — Capture scattered context into a durable knowledge document. Alias: `/知识沉淀`, `/文档沉淀`.

### Growth
- `/lark-work-diagnosis` — Diagnose the work system. Alias: `/工作诊断`, `工作状态分析`.

## Global Rules

### Authentication

```bash
lark-cli auth login --domain calendar,task,docs,drive,im,mail,vc,minutes,okr
```

If a command fails with missing permissions, ask for the minimum missing authorization or skip that source and state the gap.

### IM Messages Are a Primary Data Source

For reports, planning, and diagnosis, **always fetch IM messages**. Do not rely on calendar RSVP or meeting titles alone to judge work ownership.

- Fetch messages the user **sent** to find what they actively pushed.
- Fetch messages that **@mention the user** to find where others treat them as a decision owner.
- Paginate exhaustively. See `references/common/im-messages-guide.md`.

### Ownership Detection

Use this evidence hierarchy. Do not infer ownership from calendar alone.

1. User organized a meeting → Strong evidence
2. User was @-mentioned for a decision → Strong evidence
3. User sent messages proposing/summing up decisions → Strong evidence
4. User attended a meeting (RSVP accept) → Weak evidence; may be passive
5. User's calendar shows a busy block → No evidence of contribution

### Safety Defaults

- Use `--as user` for personal context unless the user explicitly requests bot-owned resources.
- If `~/.lark-assistant.json` exists, read it first and obey configured boundaries.
- Fetch only the minimum relevant context first; deep-dive by project/person/topic only when needed.
- Separate evidence from inference.
- Ask before sending messages or mail.
- Ask before creating, updating, or deleting tasks, calendar events, docs, files, Base records, Sheets, Wiki pages, or approvals.

### Output Style

- Do not add a fixed "data sources" section to final outputs. Mention data gaps only when they materially affect the answer.
- Do not use Markdown tables in final outputs; Lark IM and some Lark Markdown renderers handle tables poorly. Use numbered or bulleted lists instead.
- For reports and reviews, prefer human-style paragraph prose with ordered lists for key points. Avoid dense Markdown bullet lists that make the output look AI-generated.
- **Do not include agent reasoning in the final output.** Statements like "calendar shows many meetings but IM reveals..." or "from the collaboration traces it appears..." belong in working notes, not in output submitted to a manager.

## Shared References

- `references/common/im-messages-guide.md` — How to fetch and analyze IM messages, pagination pitfalls, and ownership detection.
- `references/common/reporting-standards.md` — Data collection and synthesis rules for all reports (daily, weekly, monthly, half-year, annual, OKR, project).
- `references/common/planning-standards.md` — Data collection and synthesis rules for planning (today, tomorrow, weekly, monthly).
- `references/common/diagnosis-standards.md` — Data collection and diagnosis rules for work-system analysis.
- `references/common/config-schema.md` — Recommended `~/.lark-assistant.json` schema.
- `references/common/write-safety.md` — Write-action confirmation policy.
- `references/common/context-policy.md` — Source minimization and privacy boundaries.
- `references/common/source-coverage.md` — Source coverage expectations and gap handling.
- `references/common/decision-log.md` — Durable decision-record guidance.

## Per-Command Quick Reference

### Daily Report

Window: today `00:00:00` to now.

```bash
lark-cli im +messages-search --as user --sender <open_id> --start "<day_start>" --end "<day_end>" --page-size 50 --format json
lark-cli im +messages-search --as user --is-at-me --start "<day_start>" --end "<day_end>" --page-size 50 --format json
lark-cli calendar +agenda --as user --start "<day_start>" --end "<day_end>" --format json
lark-cli task +get-my-tasks --as user --created_at "<day_start>" --format json --page-all
lark-cli task +get-my-tasks --as user --due-start "<day_start>" --due-end "<day_end>" --format json --page-all
lark-cli vc +search --as user --start "<YYYY-MM-DD>" --end "<YYYY-MM-DD>" --format json --page-size 30
```

Sections: 今日概览, 主导推进, 进行中的工作, 协作与支持, 阻塞与应对, 任务清单, 明日建议.

### Weekly Report

Window: current Monday `00:00:00` to now. Last week = last Monday through Sunday.

```bash
# Same commands as daily but with week window; paginate IM exhaustively
lark-cli im +messages-search --as user --sender <open_id> --start "<week_start>" --end "<week_end>" --page-size 50 --format json
# ...paginate all pages...
lark-cli calendar +agenda --as user --start "<week_start>" --end "<week_end>" --format json
lark-cli task +get-my-tasks --as user --created_at "<week_start>" --format json --page-all
lark-cli task +get-my-tasks --as user --due-start "<week_start>" --due-end "<week_end>" --format json --page-all
lark-cli vc +search --as user --start "<week_start_date>" --end "<week_end_date>" --format json --page-size 30
```

Sections: 本周概览, 主导与核心工作, 进行中的工作, 协作与支持, 挑战与应对, 任务清单, 下周重点.

### Monthly / Half-Year / Annual Report

Same pattern as weekly with longer windows. Use `calendar events instance_view` for historical calendar when the calendar ID is available (window must be under 40 days). Split half-year and annual into safe chunks. Deep-dive docs and VC notes by project/theme.

### Planning (Today / Tomorrow / Weekly / Monthly)

Window depends on command.

```bash
lark-cli im +messages-search --as user --sender <open_id> --start "<lookback_start>" --end "<now>" --page-size 50 --format json
lark-cli calendar +agenda --as user --start "<plan_start>" --end "<plan_end>" --format json
lark-cli task +get-my-tasks --as user --format json --page-all
```

Separate `must do`, `should do`, `could do`. Do not create or update tasks/events without confirmation.

### Meeting Brief

```bash
lark-cli calendar +agenda --as user --start "<now>" --end "<upcoming>" --format json
lark-cli im +messages-search --as user --query "<attendee_name>" --start "<lookback>" --end "<now>" --page-size 20 --format json
lark-cli vc +search --as user --start "<lookback_date>" --end "<now_date>" --format json --page-size 20
lark-cli docs +search --as user --query "<topic>" --format json --page-size 10
```

Output: meeting objective, key background, recent decisions, open questions, suggested talking points, follow-up reminders.

### Project Summary

```bash
lark-cli im +messages-search --as user --query "<project_keyword>" --start "<project_start>" --end "<now>" --page-size 50 --format json
lark-cli docs +search --as user --query "<project_keyword>" --format json --page-size 20
lark-cli vc +search --as user --start "<project_start_date>" --end "<now_date>" --format json --page-size 30
lark-cli task +get-my-tasks --as user --format json --page-all
```

Output: project overview, timeline, stakeholders, current status, risks and dependencies, source index.

### Mailbox Triage

```bash
lark-cli mail +triage --as user --format json
lark-cli im +messages-search --as user --is-at-me --start "<lookback>" --end "<now>" --page-size 50 --format json
lark-cli task +get-my-tasks --as user --format json --page-all
```

Categorize: needs reply, needs decision, needs task, FYI/archive, escalations.

### Work Diagnosis

Window: last 2–4 weeks.

```bash
lark-cli im +messages-search --as user --sender <open_id> --start "<start>" --end "<now>" --page-size 50 --format json
lark-cli calendar +agenda --as user --start "<start>" --end "<now>" --format json
lark-cli task +get-my-tasks --as user --format json --page-all
lark-cli vc +search --as user --start "<start_date>" --end "<now_date>" --format json --page-size 30
```

Focus on observable load, cadence, ownership, communication, and execution patterns. See `references/common/diagnosis-standards.md`.

### Knowledge Capture

```bash
lark-cli im +messages-search --as user --query "<topic>" --start "<start>" --end "<now>" --page-size 50 --format json
lark-cli docs +search --as user --query "<topic>" --format json --page-size 20
lark-cli vc +search --as user --start "<start_date>" --end "<now_date>" --format json --page-size 20
```

Synthesize scattered context into a durable document. Ask before creating or updating Lark Docs.
