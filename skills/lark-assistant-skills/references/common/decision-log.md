# Decision Log Strategy

Important project decisions extracted from meetings, chats, or emails should not just be summarized in chat. They must be tracked systematically.

## Sinking Knowledge to the System of Record
- When you detect an architectural, business, or project decision, prompt the user to log it.
- **Lark Docs**: Append to an existing `ADR` (Architecture Decision Record) or Project Doc.
- **Lark Base**: Add a row to a `Decisions` Base table with fields: `Date`, `Context`, `Decision`, `Consequences`, `Source Link`.
- Ensure domain vocabulary and context from `CONTEXT.md` (or `~/.lark-assistant.json`) is respected when drafting the decision record.
