---
name: lark-today-plan
description: Create today's Lark/Feishu work plan from calendar, tasks, and recent context. Use when the user asks for 今日规划, today plan, 今天安排, or /今日规划.
---

# Lark Today Plan

Create a realistic plan for today based on schedule constraints, pending tasks, and recent context.

Chinese aliases: `/今日规划`, `今天安排`, `今日计划`.

## Window

Planning day is today. Look back 3 days only when needed.

## Data Collection

If this collection is installed as a whole, follow `../lark-assistant-skills/references/common/planning-standards.md` for shared planning, source-scope, synthesis, and safety guidance. This skill remains usable without that reference.

```bash
lark-cli calendar +agenda --as user --start "<today_start_iso>" --end "<today_end_iso>" --format json
lark-cli task +get-my-tasks --as user --format json --page-all
```

Conditional context:

```bash
lark-cli vc +search --as user --start "<lookback_start_date>" --end "<today_date>" --format json --page-size 10
lark-cli docs +search --as user --query "<keyword>" --format json --page-size 10
```

Do not search mail or IM by default unless asked.

## Synthesis Rules

- Respect actual calendar capacity.
- Plan around user-owned deliverables.
- Mark meetings organized by others as preparation points, not main goals.
- Do not create or update tasks without explicit confirmation.

## Output

```md
# 今日规划（[Date]）

## 核心目标
- ...

## 时间排期与固定日程
- **[Time]**: [Meeting/Event] - *[Prep]*

## 行动清单
- **必做事项**:
- **推进与授权**:
- **可顺延**:

## 风险预警
- ...
```
