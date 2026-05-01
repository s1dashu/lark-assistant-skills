---
name: lark-setup
description: Initialize preferences, privacy boundaries, data-source scope, output destinations, and notification policy for the Lark assistant. Use when the user asks for setup, /setup, 初始化助手, 配置助手, or assistant preferences.
---

# Lark Setup

Initialize the user's Lark assistant profile before running reporting, planning, monitoring, or coaching workflows.

Chinese aliases: `/setup`, `/设置`, `初始化助手`, `配置助手`.

## Workflow

Ask for these settings and produce a configuration summary:

1. Data source scope:
   - Calendar
   - Tasks
   - Meetings / VC / Minutes
   - Docs / Wiki
   - IM messages
   - Mail
   - OKR
2. Default output destinations:
   - Send to the user by IM
   - Create or update Lark Docs
   - Write structured records to Lark Base
   - Save project memory to Wiki
3. Privacy boundaries:
   - People to ignore
   - Chats to ignore
   - Keywords or topics to ignore
   - Sources that require explicit per-run permission
4. Notification policy:
   - Standard: draft only, wait for confirmation
   - Urgent: send IM summary for high-priority items after prior authorization
   - Critical: use Lark urgent/buzz API only if explicitly configured
5. Report style:
   - Concise
   - Performance / OKR oriented
   - Management update
   - Deep review / retrospective

## Output

Return a JSON configuration summary using this schema and ask where to persist it. Do not write files, Lark Docs, Base records, or messages without explicit confirmation.

Suggested local path: `~/.lark-assistant.json`.

```json
{
  "version": 1,
  "timezone": "Asia/Shanghai",
  "language": "zh-CN",
  "source_scope": [
    "calendar",
    "task",
    "vc",
    "minutes",
    "docs",
    "wiki",
    "okr"
  ],
  "privacy": {
    "ignore_people": [],
    "ignore_chats": [],
    "ignore_keywords": [],
    "sources_require_permission": [
      "im",
      "mail"
    ]
  },
  "output": {
    "default_destination": "im",
    "doc_folder": "",
    "wiki_space": "",
    "base_app": ""
  },
  "notification_policy": {
    "mode": "draft_only",
    "urgent_alerts": false,
    "critical_buzz": false
  },
  "style": {
    "report": "concise",
    "planning": "actionable",
    "include_appendix": false
  },
  "projects": {
    "aliases": {}
  }
}
```

If this collection is installed as a whole, follow `../lark-assistant-skills/references/common/config-schema.md` for field meanings and compatibility rules.
