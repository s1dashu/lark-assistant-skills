---
name: lark-meeting-brief
description: Prepare a pre-meeting briefing from Lark calendar, contacts, past meetings, docs, tasks, and context. Use when the user asks for 会前简报, meeting brief, 会议准备, or /会前简报.
---

# Lark Meeting Brief

Prepare a concise briefing before a meeting, 1:1, review, interview, or project discussion.

Chinese aliases: `/会前简报`, `会议准备`, `帮我准备会议`.

## Data Collection



```bash
lark-cli calendar +agenda --as user --start "<window_start_iso>" --end "<window_end_iso>" --format json
```

Then gather targeted context:

```bash
lark-cli contact +search-user --as user --query "<attendee_name>"
lark-cli vc +search --as user --query "<meeting_or_project_keyword>" --start "<lookback_start_date>" --end "<today_date>" --format json --page-size 10
lark-cli docs +search --as user --query "<meeting_or_project_keyword>" --format json --page-size 10
lark-cli task +search --as user --query "<meeting_or_project_keyword>" --format json
```

## Synthesis Rules

- Find unresolved actions from previous meetings.
- Explain why key attendees matter.
- Focus on what the user needs to know, decide, ask, or avoid.
- If no history exists, state that clearly.

## Output

```md
# 会前简报：[Meeting Title]

## 核心目标
- ...

## 关键参会人
- [Name] ([Role/Department]) - ...

## 历史上下文与上次结论
- ...

## 遗留问题与待讨论
- ...

## 发言策略建议
- ...

## 会后可能动作
- ...
```

Ask before sending the brief to a meeting group or creating follow-up tasks.

