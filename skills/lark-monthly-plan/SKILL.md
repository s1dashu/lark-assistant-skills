---
name: lark-monthly-plan
description: Create a strategic monthly Lark/Feishu work plan. Use when the user asks for 本月规划, monthly plan, 下月规划, 月度计划, or /本月规划.
---

# Lark Monthly Plan

Create a monthly plan with major milestones, weekly rhythm, dependencies, and early decisions.

Chinese aliases: `/本月规划`, `月度计划`, `下月规划`.

## Window

Use current or next month based on user request. Look back 30 days.

## Data Collection

If this collection is installed as a whole, follow `../lark-assistant-skills/references/common/planning-standards.md` for shared planning, source-scope, synthesis, and safety guidance. This skill remains usable without that reference.

```bash
lark-cli calendar +agenda --as user --start "<month_start_iso>" --end "<month_end_iso>" --format json
lark-cli task +get-my-tasks --as user --format json --page-all
lark-cli docs +search --as user --query "<major_goal_or_project>" --format json --page-size 20
lark-cli vc +search --as user --start "<lookback_start_date>" --end "<today_date>" --format json --page-size 20
```

Do not fetch OKR or mail by default.

## Synthesis Rules

- Focus on milestones, not daily tasks.
- Plan only around initiatives the user owns or drives.
- Recommend a rough weekly cadence.
- Ask before writing tasks, calendar events, Docs, or Base records.

## Output

```md
# 本月规划（[Month]）

## 月度主轴
- ...

## 核心项目与里程碑
1. **[Project A]**
   - 本月目标: ...
   - 关键里程碑 / 时间节点: ...
   - 潜在风险: ...
2. **[Project B]**
   - 本月目标: ...
   - 关键里程碑 / 时间节点: ...
   - 潜在风险: ...

## 协作与支持重点
- ...

## 每周节奏预排
- **Week 1**: ...
- **Week 2**: ...
- **Week 3**: ...
- **Week 4**: ...

## 需要提前发起的关键决策/沟通
- ...
```
