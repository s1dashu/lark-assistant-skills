---
name: lark-tomorrow-plan
description: Create tomorrow's Lark/Feishu work plan. Use when the user asks for 明日规划, tomorrow plan, 明天安排, or /明日规划.
---

# Lark Tomorrow Plan

Create tomorrow's plan and identify what must be prepared tonight or first thing tomorrow.

Chinese aliases: `/明日规划`, `明天安排`, `明日计划`.

## Window

Planning day is tomorrow. Look back 3 days for unresolved context.

## Data Collection

If this collection is installed as a whole, follow `../lark-assistant-skills/references/common/planning-standards.md` for shared planning, source-scope, synthesis, and safety guidance. This skill remains usable without that reference.

```bash
lark-cli calendar +agenda --as user --start "<tomorrow_start_iso>" --end "<tomorrow_end_iso>" --format json
lark-cli task +get-my-tasks --as user --format json --page-all
```

If tomorrow has major meetings:

```bash
lark-cli vc +search --as user --start "<lookback_start_date>" --end "<today_date>" --format json --page-size 10
```

## Synthesis Rules

- Focus on the top 3 priorities.
- Distinguish personal deliverables from meetings the user merely attends.
- Suggest new tasks, but ask before creating them.

## Output

```md
# 明日规划（[Date]）

## 核心聚焦
- ...

## 日程概览与会前准备
- **[Time]**: [Meeting]
  - *会前准备*: ...

## 待办安排
- **高优推进**:
- **跟进/沟通**:

## 建议创建的待办
- ...
```
