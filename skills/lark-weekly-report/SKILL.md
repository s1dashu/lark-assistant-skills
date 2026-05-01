---
name: lark-weekly-report
description: Generate a weekly Lark/Feishu work report. Use when the user asks for weekly report, 周报, 本周总结, 上周周报, or /周报.
---

# Lark Weekly Report

Generate a weekly report focused on themes, deliverables, decisions, collaboration, risks, and next-week focus.

Chinese aliases: `/周报`, `生成周报`, `本周总结`, `上周周报`.

## Purpose

A strong weekly report should give stakeholders a concise snapshot of past, present, and future work: what was completed this week, what is still in progress, what challenges appeared, how they were handled, and what will happen next week. Keep it close to a one-page report unless the user asks for a detailed version.

Use the report to:

1. Improve transparency without requiring another status meeting.
2. Record concrete progress and performance evidence.
3. Surface blockers early while they are still actionable.
4. Align next week's priorities with current project reality.

## Window

Default to current Monday `00:00:00` to now. If the user asks for last week, use last Monday through Sunday.

## Data Collection

If this collection is installed as a whole, follow `../lark-assistant-skills/references/common/reporting-standards.md` for shared source-scope, calendar, task, synthesis, and safety guidance. This skill remains usable without that reference.

```bash
lark-cli calendar +agenda --as user --start "<week_start_iso>" --end "<week_end_iso>" --format json
lark-cli task +get-my-tasks --as user --created_at "<week_start_iso>" --format json --page-all
lark-cli task +get-my-tasks --as user --due-start "<week_start_iso>" --due-end "<week_end_iso>" --format json --page-all
lark-cli vc +search --as user --start "<week_start_date>" --end "<week_end_date>" --format json --page-size 30
```

Fetch only important meeting notes and project docs:

```bash
lark-cli vc +notes --as user --meeting-ids "<ids>"
lark-cli docs +search --as user --query "<theme_or_project>" --format json --page-size 10
```

Use mail only if external collaboration was a major theme.

`calendar +agenda` supports explicit `--start` and `--end` ISO windows and is acceptable for a concise weekly view. For fuller historical review, prefer `calendar events instance_view` with pagination when the required calendar ID is available. Use `calendar events search` only for keyword-based lookup.

## Synthesis Rules

- Group by project/theme; do not list every meeting.
- Distinguish `主导与核心工作` from `协作与支持`.
- Filter out all-hands, routine syncs, and passive reviews unless they produced a decision or action.
- Do not add a fixed data-source section. Mention permission failures or unread context only if they materially affect the report.
- Write like a human weekly report: use paragraph-style summaries and ordered lists. Avoid long Markdown bullet lists that read like AI-generated notes.
- Start with the most important outcomes, not a chronology.
- Include completed work, ongoing work, challenges and solutions, and next-week priorities.
- When there was a blocker, describe both the problem and the response or proposed next step.
- Make accomplishments concrete and verifiable: mention deliverables, decisions, shipped changes, reviewed plans, or closed tasks.
- Keep the report concise enough to scan in 2-3 minutes.

## Output

```md
# 工作周报（[Start Date] - [End Date]）

## 本周概览
用 1-2 个自然段总结本周主线、最重要的产出、关键变化、明显风险和下周承接。不要写成流水账。

## 主导与核心工作
### [Project/Theme]
1. **进展**: [用完整句说明发生了什么]
2. **结论/影响**: [用完整句说明为什么重要]

## 进行中的工作
1. **[Project/Theme]**: [说明当前进度、未完成原因、下一步动作和预期时间]

## 协作与支持
1. **[Project/Theme]**: [说明实际支持动作和结果。没有实质贡献则省略本节]

## 挑战与应对
1. **[Challenge/Blocker]**: [说明问题、影响、已采取的处理方式或需要的支持。没有挑战则写“本周暂无需要升级的阻塞。”]

## 任务清单
1. **已完成**: [只列关键完成项，不列琐碎动作]
2. **新增/进行中**: [列仍在推进的关键事项]
3. **待跟进**: [列需要下周推进、他人输入或明确截止日期的事项]

## 下周重点
1. **[Priority]**: [说明目标、关键动作和依赖]
2. **[Priority]**: ...
```

Ask before writing to Lark Docs, tasks, messages, mail, Base, or Wiki.
