# Reporting Standards

Use these standards for daily, weekly, monthly, half-year, annual, OKR, and project-style work reports. Command skills should remain runnable from their own `SKILL.md`; this file is shared guidance for consistency.

## Preconditions

- Use `--as user` for personal work context unless the user explicitly asks for bot-owned resources.
- If `~/.lark-assistant.json` exists, read it first and obey configured source scope, privacy boundaries, output destinations, notification policy, timezone, and style.
- Resolve relative dates in the configured timezone or the machine's local timezone.
- Use ISO 8601 timestamps for calendar commands that accept `--start` and `--end`. For task commands, prefer the same timestamp format even though `lark-cli task +get-my-tasks` also accepts date, relative, and millisecond forms.
- Ask before saving, sending, creating, updating, deleting, moving, or writing any Lark resource.

## Data Collection

Start with low-noise structural sources, then deep-dive only where evidence points:

1. Calendar events for the report window.
2. Tasks created, due, completed, or still pending in or around the window.
3. VC/Minutes records for meetings that produced decisions, action items, incidents, launches, reviews, or planning.
4. Docs/Wiki/Base/Sheets for named projects, goals, milestones, plans, or decisions.
5. OKR cycles when the report is performance, review, or goal-oriented.
6. IM and Mail only when requested, configured, or necessary for named external collaboration, urgent asks, unresolved commitments, or leadership-visible issues.

Avoid broad IM/mail scraping and avoid exhaustive raw daily data for long-period reviews.

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
