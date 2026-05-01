---
name: lark-monthly-report
description: Generate a monthly Lark/Feishu work report. Use when the user asks for 月报, monthly report, 月度总结, 本月工作总结, or /月报.
---

# Lark Monthly Report

Generate a strategic monthly report focused on outcomes, decisions, project themes, risks, and next-month direction.

Chinese aliases: `/月报`, `生成月报`, `月度总结`, `本月工作总结`.

## Purpose

A strong monthly report should provide a higher-level snapshot of the month: what was completed, what is still in progress, what challenges appeared and how they were handled, what changed strategically, and what should be prioritized next month. It should not be a stretched weekly report or a list of meetings.

Use the report to:

1. Summarize durable outcomes and business/product impact.
2. Connect workstreams to decisions, milestones, and risks.
3. Identify unresolved cross-month work before it becomes hidden debt.
4. Create a clean monthly record that can later feed half-year or annual reviews.

## Window

Default to the current month from the first day to now. If the user names a month, use that full calendar month.

## Data Collection

Avoid exhaustive raw fetching. Start broad, then deep-dive by project keyword:

If this collection is installed as a whole, follow `../lark-assistant-skills/references/common/reporting-standards.md` for shared source-scope, calendar, task, synthesis, and safety guidance. This skill remains usable without that reference.

```bash
lark-cli calendar +agenda --as user --start "<month_start_iso>" --end "<month_end_iso>" --format json
lark-cli task +get-my-tasks --as user --created_at "<month_start_iso>" --format json --page-all
lark-cli task +get-my-tasks --as user --due-start "<month_start_iso>" --due-end "<month_end_iso>" --format json --page-all
lark-cli vc +search --as user --start "<month_start_date>" --end "<month_end_date>" --format json --page-size 30
lark-cli docs +search --as user --query "<major_project_or_goal>" --format json --page-size 20
```

Fetch notes only for the most important meetings. Search mail, IM, or OKR only when requested or when the report would otherwise miss a known major workstream.

`calendar +agenda` supports explicit `--start` and `--end` ISO windows and is acceptable for a concise monthly view. For fuller historical review, prefer `calendar events instance_view` with pagination when the required calendar ID is available. Use `calendar events search` only for keyword-based lookup.

## Synthesis Rules

- Emphasize led/owned work over passive attendance.
- Summarize by major project or strategic theme.
- Include completed milestones and cross-month pending items.
- Separate facts from interpretation.
- Do not add a fixed data-source section. Mention missing context only if it materially affects the monthly conclusions.
- Write like a human monthly report: use short paragraphs for summaries and ordered lists for key points. Avoid generic Markdown bullet dumps.
- Start with the month's most important outcomes and strategic changes, not a chronology.
- Include completed milestones, ongoing work, challenges and solutions, and next-month priorities.
- When there was a challenge, describe the problem, response, remaining risk, and next owner/action.
- Make impact concrete: shipped capability, aligned decision, closed milestone, reduced risk, enabled team, or unblocked dependency.
- Keep the main report concise; move lower-value details into the author's own notes instead of the final output.

## Output

```md
# [Month] 工作总结（[Start] - [End]）

## 周期总览
用 1-2 个自然段总结本月工作主线、阶段性结果、关键变化和整体判断。

## 主导核心项目与成果
### [Major Project]
1. **产出与影响**: [用完整句说明交付、影响和证据]
2. **关键转折**: [说明本月发生的决策、变化或取舍]

## 进行中的工作
1. **[Project/Theme]**: [说明当前状态、未完成原因、下月动作和预期节点]

## 协作与跨团队支持
1. **[Theme/Project]**: [说明实际协作贡献和结果。没有实质贡献则省略本节]

## 挑战与应对
1. **[Challenge/Risk]**: [说明问题、影响、已采取的处理方式、剩余风险和下一步 owner/action。没有挑战则写“本月暂无需要升级的阻塞。”]

## 组织协作与能力沉淀
用 1 个自然段说明跨团队协作、机制建设或可复用方法。

## 核心清单回溯
1. **已完成重大里程碑**: ...
2. **新增/进行中事项**: ...
3. **跨周期遗留/待跟进**: ...

## 下一阶段建议方向
1. **[Priority]**: [说明目标、关键动作和依赖]
2. **[Priority]**: ...
```

Ask before saving to Lark Docs/Base/Wiki or sending to anyone.
