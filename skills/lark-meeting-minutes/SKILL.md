---
name: lark-meeting-minutes
description: Produce structured minutes for a single Lark/Feishu meeting from VC notes, Minutes, calendar context, and related docs. Use when the user asks for 会议纪要, meeting minutes, 会后总结, action items, or /会议纪要.
---

# Lark Meeting Minutes

Create structured minutes for one completed meeting, including decisions, action items, owners, deadlines, open questions, and follow-up drafts.

Chinese aliases: `/会议纪要`, `会后总结`, `整理会议纪要`, `提取 action items`.

## Preconditions

- Use `--as user` for meeting, calendar, docs, and Minutes context unless the user explicitly requests bot-owned resources.
- If `~/.lark-assistant.json` exists, read it first and obey configured privacy boundaries, source scope, output destination, timezone, and style.
- If this collection is installed as a whole, follow `../lark-assistant-skills/references/common/config-schema.md`, `../lark-assistant-skills/references/common/reporting-standards.md`, and `../lark-assistant-skills/references/common/write-safety.md` for shared configuration, synthesis, and safety guidance. This skill remains usable without those references.
- Ask before sending minutes, creating tasks, updating docs, or posting to a meeting group.

## Meeting Identification

If the user provides a meeting ID, minute token, calendar event ID, or Minutes URL, use it directly. Otherwise search recent completed meetings by title, participant, or date.

```bash
lark-cli vc +search --as user --query "<meeting_or_project_keyword>" --start "<start_date>" --end "<end_date>" --format json --page-size 10
lark-cli minutes +search --as user --query "<meeting_or_project_keyword>" --start "<start_date>" --end "<end_date>" --format json --page-size 10
```

For a meeting from today's or yesterday's calendar:

```bash
lark-cli calendar +agenda --as user --start "<day_start_iso>" --end "<day_end_iso>" --format json
```

## Data Collection

Fetch meeting notes or Minutes artifacts for the selected meeting:

```bash
lark-cli vc +notes --as user --meeting-ids "<meeting_ids>" --format json
lark-cli vc +notes --as user --minute-tokens "<minute_tokens>" --format json
lark-cli vc +notes --as user --calendar-event-ids "<calendar_event_ids>" --format json
```

Use related docs or tasks only when the notes reference them or the user asks for project context:

```bash
lark-cli docs +search --as user --query "<project_or_doc_keyword>" --format json --page-size 10
lark-cli task +search --as user --query "<project_or_action_keyword>" --format json
```

Avoid dumping full transcripts into the final answer. Summarize and quote only short fragments when necessary.

## Synthesis Rules

- Identify the meeting objective before listing details.
- Separate confirmed decisions from discussion points and hypotheses.
- Extract action items with owner, deadline, dependency, and confidence. If owner or deadline is missing, mark it as `待确认`.
- Do not create tasks automatically; propose them first.
- Keep sensitive or off-topic transcript content out of the final minutes unless the user explicitly asks.
- If notes are unavailable, produce a lightweight summary from calendar title, attendees, and related docs, clearly marked as low confidence.

## Output

```md
# 会议纪要：[Meeting Title]

## 会议目标
用 1-2 句话说明这次会议要解决的问题。

## 核心结论
1. **[Decision]**: [说明决定、原因和影响]

## 关键讨论
1. **[Topic]**: [概述分歧、信息、判断或取舍]

## 行动项
1. **[Action]**
   - Owner: [Name / 待确认]
   - Deadline: [Date / 待确认]
   - Dependency: [Dependency / 无]
   - Confidence: 高 / 中 / 低

## 未决问题
1. **[Question]**: [需要谁确认、建议何时确认]

## 建议跟进
1. **任务建议**: [可创建的任务，但不直接创建]
2. **消息草稿**:
   > [需要发送时的草稿]
```

Ask before saving the minutes to Lark Docs/Wiki, sending them to a group, or creating follow-up tasks.
