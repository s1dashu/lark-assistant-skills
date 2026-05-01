---
name: lark-project-summary
description: Summarize a project from scattered Lark Docs, Wiki, meetings, tasks, messages, and mail. Use when the user asks for 项目总结, project summary, 项目复盘, or /项目总结.
---

# Lark Project Summary

Build or refresh a durable project memory from Lark artifacts.

Chinese aliases: `/项目总结`, `项目复盘`, `项目记忆`.

## Data Collection

To build a true project memory, use **Timeline Tracing** rather than blind global searches.

1. **Locate Key Documents & Kick-offs**:
```bash
lark-cli docs +search --as user --query "<project_keyword> (PRD OR 规划 OR 启动 OR Kickoff)" --format json --page-size 5
lark-cli vc +search --as user --query "<project_keyword> (启动 OR 同步 OR 复盘)" --start "<start_date>" --end "<end_date>" --format json --page-size 10
```

2. **Identify Current Blockers & Tasks**:
```bash
lark-cli task +search --as user --query "<project_keyword>" --format json
```

3. **Latest Sync/Conversations (Conditional)**:
Only if recent status is unclear, search recent IM for the project keyword:
```bash
lark-cli im +messages-search --as user --query "<project_keyword>" --start "<last_14_days_iso>" --format json --page-limit 2
```

## Synthesis Rules (Assistant Viewpoint)

- **Timeline Construction**: Build a milestone timeline (起点 Kick-off -> 关键拐点 Milestones -> 当前状态 Current).
- **Identify Orphaned Tasks & Risks**: Actively scan for tasks assigned but not updated in > 2 weeks, or action items mentioned in meetings without a tracking task. Call these out as risks.
- **Extract Actual Decisions**: Pull out architectural, business, or resource decisions made along the way.
- **Durable Memory**: Project summaries should not be ephemeral chat messages. **Always ask the user for a Wiki node ID or folder URL to save this summary as a permanent Lark Doc.**

## Output

```md
# 项目总结与记忆：[Project Name]

## 概况与角色
- **项目背景**: ...
- **用户角色**: ...
- **当前大盘状态**: (On-track / At-risk / Blocked / Completed)

## 里程碑时间线 (Timeline)
- `YYYY-MM-DD`: 项目启动 (Kick-off)
- `YYYY-MM-DD`: [关键决策/拐点]
- `YYYY-MM-DD`: 最新状态同步

## 关键决策库 (Decision Log)
- ...

## 风险与“孤儿”待办预警 (Risks & Orphans)
- ⚠️ **超期/停滞待办**: ...
- ⚠️ **无 Owner 动作**: (会议记录中提及但无飞书任务的事项)

```

**CRITICAL**: Prompt the user with: "是否需要将此项目记忆沉淀为飞书文档/存入 Wiki？(请提供存放的 URL)"
