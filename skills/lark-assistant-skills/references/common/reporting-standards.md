# Reporting Standards

Use these standards for daily, weekly, monthly, half-year, annual, OKR, and project-style work reports.

## Preconditions

- Use `--as user` for personal work context unless the user explicitly asks for bot-owned resources.
- If `~/.lark-assistant.json` exists, read it first and obey configured source scope, privacy boundaries, output destinations, notification policy, timezone, and style.
- Resolve relative dates in the configured timezone or the machine's local timezone.
- Use ISO 8601 timestamps for calendar commands that accept `--start` and `--end`. For task commands, prefer the same timestamp format even though `lark-cli task +get-my-tasks` also accepts date, relative, and millisecond forms.
- Ask before saving, sending, creating, updating, deleting, moving, or writing any Lark resource.

## Data Collection

**IM messages are a primary data source, not an optional deep-dive.** Calendar titles and RSVP status alone cannot distinguish passive attendance from active ownership. Always fetch messages before synthesizing.

Collection order:

1. **IM messages** - Fetch exhaustively with pagination. See `im-messages-guide.md`.
   - Messages sent by the user
   - Messages that @mention the user
   - Group by chat_name to find active workspaces
2. **Calendar events** - For the report window, to understand time allocation.
3. **Tasks** - Created, due, completed, or still pending in or around the window.
4. **VC/Minutes** - For meetings that produced decisions, action items, or reviews.
5. **Docs/Wiki/Base/Sheets** - For named projects, goals, milestones, plans, or decisions.
6. **OKR cycles** - When the report is performance, review, or goal-oriented.
7. **Mail** - Only when external collaboration was a major theme.

Avoid broad mail scraping and avoid exhaustive raw daily data for long-period reviews.

## IM-Driven Ownership Detection

Do not infer work ownership from calendar RSVP alone. Use this hierarchy:

1. **User organized a meeting** → Strong evidence of ownership
2. **User was @-mentioned for a decision** → Strong evidence of ownership
3. **User sent messages proposing/summing up decisions** → Strong evidence of ownership
4. **User attended a meeting (RSVP accept)** → Weak evidence; may be passive attendance
5. **User's calendar shows a busy block** → No evidence of contribution

If a meeting appears on the calendar but the user has zero messages in the related chat, treat it as passive attendance unless meeting notes show active contribution.

## Calendar Query Guidance

`lark-cli calendar +agenda --start ... --end ...` supports explicit ISO time windows and is acceptable for a concise agenda-style view.

For historical reviews that need fuller event instances and the calendar ID is available, prefer `calendar events instance_view`. It uses Unix timestamps and each query window must be under 40 days, so split monthly, half-year, or annual reviews into safe windows. Check the local schema before calling because `calendar_id` is a path parameter:

```bash
lark-cli schema calendar.events.instance_view
lark-cli calendar events instance_view --as user --params '{"calendar_id":"<calendar_id>","start_time":"<start_epoch>","end_time":"<end_epoch>"}' --format json --page-all
```

For keyword-based historical lookup, use `calendar events search` with a non-empty query and a filter:

```bash
lark-cli schema calendar.events.search
lark-cli calendar events search --as user --params '{"calendar_id":"primary"}' --data '{"query":"<keyword>","filter":{"start_time":{"timestamp":"<start_epoch>","timezone":"Asia/Shanghai"},"end_time":{"timestamp":"<end_epoch>","timezone":"Asia/Shanghai"}}}' --format json --page-all
```

If the lower-level command requires an exact calendar ID or schema detail that is unavailable, fall back to `calendar +agenda` and state the limitation only if it materially affects the report.

## Task Query Guidance

Current `lark-cli task +get-my-tasks` uses mixed flag naming:

```bash
lark-cli task +get-my-tasks --as user --created_at "<start_iso>" --format json --page-all
lark-cli task +get-my-tasks --as user --due-start "<start_iso>" --due-end "<end_iso>" --format json --page-all
```

The underscore in `--created_at` and hyphenated `--due-start` / `--due-end` are intentional CLI flags.

## Synthesis

- Start with the most important outcome, risk, or decision, not a chronology.
- Group by project, theme, outcome, or goal rather than listing meetings.
- Separate `主导负责`, `核心推进`, `重要协作`, and passive attendance.
- Do not inflate passive meeting attendance into contribution.
- Distinguish facts, interpretation, risks, and recommended next actions.
- Use confidence labels for high-stakes or long-period claims when evidence is uneven.
- Mention data gaps naturally where they affect a conclusion. Do not add a fixed data-source inventory.
- Keep final reports human-readable: short paragraphs for overview and ordered lists for key points. Avoid Markdown tables and dense bullet dumps.
- **Do not include agent reasoning in the final output.** Statements like "calendar shows many meetings but IM reveals..." or "from the collaboration traces it appears..." belong in your working notes, not in a report submitted to a manager. The final output should present facts and conclusions directly.

## Output Templates

### Daily Report

```md
# 工作日报（[Date]）

## 今日重点工作

1. **[Project/Theme]**
   1. [Specific action or decision]
   2. [Specific action or decision]

2. **[Project/Theme]**
   1. [Specific action or decision]

## 明日计划

1. **[Priority]**: [目标、关键动作和依赖]
2. **[Priority]**: [目标、关键动作和依赖]
```

### Weekly Report - Full Format

Use when the user wants a standard one-page weekly report.

```md
# 工作周报([Start Date] - [End Date])

## 本周概览
用 1-2 个自然段总结本周主线、最重要的产出、关键变化、明显风险和下周承接。不要写成流水账。

## 主导与核心工作
### [Project/Theme]
1. **进展**: [用完整句说明发生了什么]
2. **结论/影响**: [用完整句说明为什么重要]

## 进行中的工作
1. **[Project/Theme]**: [说明当前进度、未完成原因、下一步动作和预期时间]

## 协作与支持
1. **[Project/Theme]**: [说明实际支持动作和结果。没有实质贡献则省略本节]

## 挑战与应对
1. **[Challenge/Blocker]**: [说明问题、影响、已采取的处理方式或需要的支持。没有挑战则写"本周暂无需要升级的阻塞。"]

## 任务清单
1. **已完成**: [只列关键完成项,不列琐碎动作]
2. **新增/进行中**: [列仍在推进的关键事项]
3. **待跟进**: [列需要下周推进、他人输入或明确截止日期的事项]

## 下周重点
1. **[Priority]**: [说明目标、关键动作和依赖]
2. **[Priority]**: ...
```

### Weekly Report - Concise Format

Use when the user prefers a minimal format for quick manager review.

```md
# 工作周报([Start Date] - [End Date])

## 本周重点工作

1. **[Project/Theme]**
   1. [Specific action or decision]
   2. [Specific action or decision]

2. **[Project/Theme]**
   1. [Specific action or decision]
   2. [Specific action or decision]

3. **[Project/Theme]**
   1. [Specific action or decision]

## 下周重点工作

1. **[Priority]**: [目标、关键动作和依赖]
2. **[Priority]**: [目标、关键动作和依赖]
3. **[Priority]**: [目标、关键动作和依赖]
```

### Monthly / Half-Year / Annual Report

```md
# 工作月报（[Start Date] - [End Date]）

## 本月重点工作

1. **[Project/Theme]**
   1. [Specific action or decision]
   2. [Specific action or decision]

2. **[Project/Theme]**
   1. [Specific action or decision]

## 下月重点工作

1. **[Priority]**: [目标、关键动作和依赖]
2. **[Priority]**: [目标、关键动作和依赖]
```

For half-year and annual reports, extend the same concise format with a "回顾与复盘" section for themes, patterns, and lessons learned. Expand data sources to include OKR, docs, and longer-range VC records. Split `calendar events instance_view` into multiple queries if the window exceeds 40 days.
