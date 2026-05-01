---
name: lark-daily-report
description: Generate a same-day or single-day Lark/Feishu work report. Use when the user asks for daily report, 日报, 今日工作总结, yesterday report, or /日报.
---

# Lark Daily Report

Generate a professional Chinese daily report focused on concrete activity, decisions, blockers, and tomorrow's next actions. Avoid laundry lists and passive meeting attendance.

Chinese aliases: `/日报`, `生成日报`, `今日工作总结`, `昨天日报`.

## Purpose

A strong daily report should give the user and close collaborators a concise snapshot of the workday: what was completed, what is still in progress, what decisions or blockers appeared, how blockers were handled, and what should happen tomorrow. Keep it short enough to read in 1-2 minutes.

Use the report to:

1. Record concrete progress while context is still fresh.
2. Surface same-day blockers before they become week-long delays.
3. Make tomorrow's first actions obvious.
4. Preserve performance evidence without turning the report into a meeting list.

## Window

Default to today from `00:00:00` to now in the user's timezone. If the user asks for yesterday or a specific date, resolve that exact local day.

## Data Collection

Use user identity for private context. Fetch structural data first:

If this collection is installed as a whole, follow `../lark-assistant-skills/references/common/reporting-standards.md` for shared source-scope, calendar, task, synthesis, and safety guidance. This skill remains usable without that reference.

```bash
lark-cli calendar +agenda --as user --start "<day_start_iso>" --end "<day_end_iso>" --format json
lark-cli task +get-my-tasks --as user --created_at "<day_start_iso>" --format json --page-all
lark-cli task +get-my-tasks --as user --due-start "<day_start_iso>" --due-end "<day_end_iso>" --format json --page-all
lark-cli vc +search --as user --start "<YYYY-MM-DD>" --end "<YYYY-MM-DD>" --format json --page-size 30
```

Deep-dive only when needed:

```bash
lark-cli vc +notes --as user --meeting-ids "<ids>"
lark-cli docs +search --as user --query "<project_or_keyword>" --format json --page-size 10
```

Do not read mail or IM by default unless the user asks or the day clearly involved external/message-heavy collaboration.

`calendar +agenda` supports explicit `--start` and `--end` ISO windows and is acceptable for a concise day view. If the day requires a fuller historical audit and the calendar ID is available, use `calendar events instance_view` for the same time window. Use `calendar events search` only for keyword-based lookup.

## Synthesis Rules

- Separate led work from support work.
- Treat meetings the user organized or drove as `主导推进`.
- Include work driven by others only when there is evidence of active contribution.
- Do not list meetings the user merely attended.
- Separate completed, new, and pending tasks.
- Do not add a fixed data-source section. Mention missing context only if it materially affects the report.
- Write like a human professional report: prefer short paragraph-style prose and ordered lists. Avoid dense Markdown bullet lists that look AI-generated.
- Start with the most important outcome or blocker, not the first calendar event.
- Include completed work, ongoing work, blockers and response, and tomorrow's priorities.
- When a blocker exists, describe the impact and the next action or owner.
- Keep accomplishments concrete: decisions made, drafts completed, reviews finished, tasks closed, launches prepared, or stakeholder alignment reached.

## Output

```md
# 工作日报（[Date]）

## 今日概览
用 1 个自然段总结今天最重要的进展、决策或阻塞，不要写成碎片化列表。

## 主导推进
1. **[Project/Task]**: [用 2-3 句话说明进展、结果、影响或下一步]

## 进行中的工作
1. **[Project/Task]**: [说明当前进度、未完成原因和明天的下一步动作]

## 协作与支持
1. **[Project/Task]**: [用 1-2 句话说明实际贡献。没有实质贡献则省略本节]

## 阻塞与应对
1. **[Blocker]**: [说明问题、影响、已采取的处理方式或需要谁支持。没有阻塞则写“今天暂无需要升级的阻塞。”]

## 任务清单
1. **已完成**: [只列关键完成项]
2. **新增/进行中**: [列仍需推进的关键事项]
3. **待跟进**: [列需要他人输入或明确截止日期的事项]

## 明日建议
1. **[Priority]**: [说明目标、关键动作和依赖]
2. **[Priority]**: ...
```

Ask before creating or updating any Lark Doc, task, event, IM, mail, Base record, or Wiki page.
