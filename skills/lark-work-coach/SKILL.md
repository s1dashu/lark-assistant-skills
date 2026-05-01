---
name: lark-work-coach
description: Provide professional work coaching based on Lark context, focusing on communication, prioritization, collaboration, stakeholder management, and operating cadence. Use when the user asks for 工作教练, coaching, 提升工作方式, or /工作教练.
---

# Lark Work Coach

Provide high-level behavioral coaching grounded in work evidence. Make advice practical and behavior-level.

Chinese aliases: `/工作教练`, `工作指导`, `提升工作方式`.

## Data Collection

```bash
lark-cli calendar +agenda --as user --start "<start_iso>" --end "<end_iso>" --format json
lark-cli task +get-my-tasks --as user --format json --page-all
lark-cli vc +search --as user --start "<start_date>" --end "<end_date>" --format json --page-size 20
lark-cli docs +search --as user --query "<focus_keyword>" --format json --page-size 10
```

Do not search IM or mail blindly.

## Coaching Lens

- Meeting quality and necessity.
- Prioritization discipline.
- Stakeholder management.
- Follow-through system.
- How to decline work the user does not own.

## Output

```md
# 工作教练建议

## 当前工作模式透视
- ...

## 最值得优化的 3 个工作习惯
1. **[Area]**: ...
2. ...
3. ...

## 策略与沟通建议
- **精力分配**: ...
- **沟通/协作机制**: ...

## 下周行为实验
- **实验动作**: ...
- **预期效果**: ...
- **衡量方式**: ...

## 引导反思的问题
- ...
```

Do not mutate Lark data without confirmation.
