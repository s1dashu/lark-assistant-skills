---
name: lark-work-diagnosis
description: Diagnose the user's recent work system from Lark context, including meeting load, task accumulation, communication gaps, execution risks, and work patterns. Use when the user asks for 工作诊断, work diagnosis, 工作状态分析, or /工作诊断.
---

# Lark Work Diagnosis

Diagnose the user's work system, not their personality. Focus on observable load, cadence, ownership, communication, and execution patterns.

Chinese aliases: `/工作诊断`, `工作状态分析`, `诊断我的工作方式`.

## Data Collection

```bash
lark-cli calendar +agenda --as user --start "<start_iso>" --end "<end_iso>" --format json
lark-cli task +get-my-tasks --as user --format json --page-all
lark-cli vc +search --as user --start "<start_date>" --end "<end_date>" --format json --page-size 30
lark-cli docs +search --as user --query "<focus_keyword>" --format json --page-size 10
```

Do not fetch OKR, mail, or IM unless requested.

## Diagnosis Rules

- Separate evidence from inference.
- Avoid clinical or personality judgments.
- Identify passive meeting load and ownership gaps.
- Prefer system-level fixes over vague advice.

## Output

```md
# 工作负荷与系统诊断（[Start Date] - [End Date]）

## 诊断摘要
- ...

## 核心发现与推断
### [Issue/Pattern]
- **证据**: ...
- **推断**: ...
- **影响**: ...
- **建议**: ...

## 立刻可做的 3 个系统调整
1. ...
2. ...
3. ...
```

Ask before changing tasks, calendar, messages, mail, docs, or Base records.
