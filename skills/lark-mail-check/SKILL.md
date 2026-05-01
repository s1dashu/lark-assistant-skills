---
name: lark-mail-check
description: Triage the user's Lark mail inbox and draft reply suggestions. Use when the user asks for 邮箱检查, check mail, inbox triage, 邮件处理, or /邮箱检查.
---

# Lark Mail Check

Check the mailbox and produce an actionable, noise-free triage report.

Chinese aliases: `/邮箱检查`, `检查邮箱`, `邮件处理`.

## Data Collection

```bash
lark-cli mail +triage --as user --format json --max 30
```

Targeted deep-dive:

```bash
lark-cli mail +triage --as user --query "<keyword>" --format json --max 10
lark-cli mail +thread --as user --thread-id "<thread_id>" --format json
```

## Synthesis Rules

- Ignore newsletters, system notifications, and generic FYI unless important.
- Classify strictly by action required.
- Draft replies only when useful; never send automatically.

## Output

```md
# 邮箱检查汇报

## 需要处理/回复
- **[Sender]** - [Subject]
  - *摘要*: ...
  - *建议*: ...

## 待决策/需建待办
- ...

## 抄送通知
- ...

## 草稿建议
...
```

Ask for explicit final confirmation before replying, forwarding, sending, archiving, deleting, or creating tasks.

