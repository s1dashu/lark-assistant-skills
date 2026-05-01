---
name: lark-weekly-plan
description: Create a strategic weekly Lark/Feishu work plan. Use when the user asks for 本周规划, weekly plan, 下周规划, or /本周规划.
---

# Lark Weekly Plan

Create a weekly plan organized around 2-3 major themes, dependencies, and capacity.

Chinese aliases: `/本周规划`, `本周计划`, `下周规划`.

## Window

Use current week if requested on Monday or Tuesday; use next week if the user asks late in the week or explicitly says next week. Look back 7-14 days.

## Data Collection

If this collection is installed as a whole, follow `../lark-assistant-skills/references/common/planning-standards.md` for shared planning, source-scope, synthesis, and safety guidance. This skill remains usable without that reference.

```bash
lark-cli calendar +agenda --as user --start "<week_start_iso>" --end "<week_end_iso>" --format json
lark-cli task +get-my-tasks --as user --format json --page-all
lark-cli vc +search --as user --start "<lookback_start_date>" --end "<today_date>" --format json --page-size 20
lark-cli docs +search --as user --query "<major_project_keyword>" --format json --page-size 10
```

Do not fetch OKR or mail unless requested.

## Synthesis Rules

- Prioritize user-owned projects.
- Call out dependencies requiring early alignment.
- Do not dump chronological meeting lists.
- Ask before creating tasks/calendar blocks.

## Output

```md
# 本周规划（[Start Date] - [End Date]）

## 本周主线聚焦
- ...

## 主导核心项目
### [Project]
- **本周目标**: ...
- **关键动作**: ...
- **依赖/阻塞**: ...

## 协作与跨团队支持
- ...

## 关键会议节点
- ...

## 风险预警
- ...
```
