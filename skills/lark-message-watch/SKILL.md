---
name: lark-message-watch
description: Run one pass of recent Lark IM and mail monitoring, classify urgency, draft replies, and propose escalation. Use when the user asks for 消息检查, message watch, 定时消息检查, reply drafting, or /消息检查.
---

# Lark Message Watch

Perform one pass of recent message and mail monitoring. Do not run an infinite loop in shell. For periodic checks, call this skill from an external scheduler such as cron or a host-level scheduled workflow.

Chinese aliases: `/消息检查`, `/定时消息检查`, `检查消息`, `消息监控`.

## Data Collection

Use a recent time window: last check time or `now - 1h`.

```bash
lark-cli im +messages-search --as user --is-at-me --start "<start_iso>" --end "<now_iso>" --format json --page-all --page-limit 5
lark-cli mail +triage --as user --format json --max 20
```

For configured monitored chats:

```bash
lark-cli im +chat-messages-list --as user --chat-id "<chat_id>" --start "<start_iso>" --end "<now_iso>" --format json --max 20
```

## Classification

- Urgent: blocker, incident, deadline within 24h, or direct executive escalation.
- Action required: normal asks needing reply or task.
- FYI: important non-actionable updates.
- Ignore idle chat, acknowledgements, and system noise.

## Output

```md
# 消息与邮件监控（[Start Time] - [End Time]）

## 紧急事项与阻塞
- **来源**: ...
- **摘要**: ...
- **建议动作**: ...

## 待回复 / 待跟进
- **来源**: ...
- **摘要**: ...
- **建议回复草稿**:
  > ...

## 仅供参考
- ...
```

Do not send replies or urgent alerts without prior authorization or explicit confirmation. If urgent alerting is configured, propose the Lark urgent API call before executing.
