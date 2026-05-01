---
name: lark-assistant-skills
description: Index skill for the Lark/Feishu assistant skills collection. Use to discover available lark-* assistant commands and understand shared design, not as the primary workflow entry point.
---

# Lark Assistant Skills

This is the collection index for Lark/Feishu personal assistant skills. Prefer invoking the specific command skills below instead of this index skill.

## Primary Commands

Setup:
- `/lark-setup`: initialize data-source scope, privacy boundaries, output destinations, and notification policy.

Reports:
- `/lark-daily-report`: daily report. Chinese alias: `/日报`.
- `/lark-weekly-report`: weekly report. Chinese alias: `/周报`.
- `/lark-monthly-report`: monthly report. Chinese alias: `/月报`.
- `/lark-half-year-review`: half-year review. Chinese alias: `/半年总结`.
- `/lark-annual-review`: annual review. Chinese aliases: `/全年总结`, `/年终总结`.
- `/lark-okr-review`: OKR progress and alignment review. Chinese alias: `/OKR复盘`.

Planning:
- `/lark-today-plan`: today's plan. Chinese alias: `/今日规划`.
- `/lark-tomorrow-plan`: tomorrow's plan. Chinese alias: `/明日规划`.
- `/lark-weekly-plan`: weekly plan. Chinese alias: `/本周规划`.
- `/lark-monthly-plan`: monthly plan. Chinese alias: `/本月规划`.

Assistant workflows:
- `/lark-meeting-brief`: pre-meeting briefing. Chinese alias: `/会前简报`.
- `/lark-meeting-minutes`: single-meeting minutes and follow-up extraction. Chinese alias: `/会议纪要`.
- `/lark-project-summary`: project summary. Chinese alias: `/项目总结`.
- `/lark-mail-check`: mailbox triage. Chinese alias: `/邮箱检查`.
- `/lark-document-memory`: durable document memory. Chinese alias: `/文档沉淀`.
- `/lark-message-watch`: recent message/mail monitoring. Chinese alias: `/消息检查`.

Growth:
- `/lark-work-diagnosis`: diagnose the work system. Chinese alias: `/工作诊断`.
- `/lark-work-coach`: professional work coaching. Chinese alias: `/工作教练`.
- `/lark-emotional-support`: non-clinical emotional support. Chinese alias: `/心理辅导`.

## Shared Operating Rules

Prefer user identity for personal context:

```bash
lark-cli auth login --domain calendar,task,docs,drive,im,mail,vc,minutes,okr
```

If a command fails with missing permissions, ask for the minimum missing authorization or skip that source and state the gap.

All command skills must:
- If `~/.lark-assistant.json` exists, read it before data collection and obey configured privacy boundaries, source scope, output destinations, and notification policy.
- Fetch only the minimum relevant context first.
- Deep-dive by project/person/topic only when needed.
- Separate evidence from inference.
- Do not add a fixed "data sources" section to final outputs. Mention data gaps only when they materially affect the answer.
- Do not use Markdown tables in final outputs; Lark IM and some Lark Markdown renderers handle tables poorly. Use numbered or bulleted lists instead.
- For reports and reviews, prefer human-style paragraph prose with ordered lists for key points. Avoid dense Markdown bullet lists that make the output look AI-generated.
- Ask before sending messages or mail.
- Ask before creating, updating, or deleting tasks, calendar events, docs, files, Base records, Sheets, Wiki pages, or approvals.

## Optional Common References

When this collection is installed as a whole, command skills may use these references for consistency:

- `references/common/config-schema.md`: recommended `~/.lark-assistant.json` schema.
- `references/common/reporting-standards.md`: common report/review data collection and synthesis rules.
- `references/common/planning-standards.md`: common planning data collection and synthesis rules.
- `references/common/write-safety.md`: write-action confirmation policy.
- `references/common/context-policy.md`: source minimization and privacy boundaries.
- `references/common/source-coverage.md`: source coverage expectations and gap handling.
- `references/common/decision-log.md`: durable decision-record guidance.
