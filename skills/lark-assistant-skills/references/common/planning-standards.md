# Planning Standards

Use these standards for today, tomorrow, weekly, monthly, and custom-period planning skills. Command skills should stay self-contained; this file keeps shared behavior consistent.

## Preconditions

- Use `--as user` for personal calendar, tasks, docs, meetings, mail, and chat context.
- If `~/.lark-assistant.json` exists, read it first and obey configured source scope, privacy boundaries, notification policy, timezone, and style.
- Resolve planning windows in the configured timezone or the machine's local timezone.
- Do not create or update tasks, events, docs, messages, mail, Base records, or Wiki pages without explicit confirmation.

## Data Collection

Collect enough context to plan realistically, not enough to reconstruct the user's entire history:

1. Calendar commitments in the planning window.
2. Current tasks, overdue tasks, due-soon tasks, and explicit priorities.
3. Recent meeting action items and unresolved decisions when they affect the plan.
4. Relevant docs, project plans, OKRs, or prior planning docs for major goals.
5. Recent IM/Mail asks only when requested, configured, or clearly necessary for urgent follow-up.

For planning windows, `calendar +agenda --start ... --end ...` is the preferred concise calendar view.

## Synthesis

- Respect actual calendar capacity and focus time.
- Separate `must do`, `should do`, and `could do`.
- Distinguish user-owned deliverables from meetings the user merely attends.
- Use time-blocking only when calendar data supports it.
- Highlight dependencies that need early alignment.
- Suggest task or calendar changes as proposals, then ask before executing.
- Keep plans action-oriented: each priority should name the intended outcome, next action, dependency, and rough timing when useful.

## Output Style

- Avoid Markdown tables.
- Prefer short sections, ordered lists for priorities, and concise natural language.
- Do not include a fixed data-source section. Mention missing context only when it materially changes the plan.
