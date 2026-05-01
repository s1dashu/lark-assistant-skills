# Planning Standards

Use these standards for today, tomorrow, weekly, monthly, and custom-period planning.

## Preconditions

- Use `--as user` for personal calendar, tasks, docs, meetings, mail, and chat context.
- If `~/.lark-assistant.json` exists, read it first and obey configured source scope, privacy boundaries, notification policy, timezone, and style.
- Resolve planning windows in the configured timezone or the machine's local timezone.
- Do not create or update tasks, events, docs, messages, mail, Base records, or Wiki pages without explicit confirmation.

## Data Collection

Collect enough context to plan realistically, not enough to reconstruct the user's entire history:

1. **IM messages** — Fetch exhaustively. See `im-messages-guide.md`.
   - Recent messages reveal what the user is actively pushing vs. what is stalled
   - @mentions show where others are waiting on the user
   - Chat distribution shows which projects are currently hot
2. **Calendar commitments** in the planning window.
3. **Current tasks, overdue tasks, due-soon tasks**, and explicit priorities.
4. **Recent meeting action items** and unresolved decisions when they affect the plan.
5. **Relevant docs, project plans, OKRs**, or prior planning docs for major goals.
6. **Mail** only when requested, configured, or clearly necessary for urgent follow-up.

For planning windows, `calendar +agenda --start ... --end ...` is the preferred concise calendar view.

## Synthesis

- Respect actual calendar capacity and focus time.
- Separate `must do`, `should do`, and `could do`.
- Distinguish user-owned deliverables from meetings the user merely attends. Use IM evidence, not just calendar RSVP.
- Use time-blocking only when calendar data supports it.
- Highlight dependencies that need early alignment.
- Suggest task or calendar changes as proposals, then ask before executing.
- Keep plans action-oriented: each priority should name the intended outcome, next action, dependency, and rough timing when useful.

## Output Style

- Avoid Markdown tables.
- Prefer short sections, ordered lists for priorities, and concise natural language.
- Do not include a fixed data-source section. Mention missing context only when it materially changes the plan.
