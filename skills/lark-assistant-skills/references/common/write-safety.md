# Write Safety and Confirmation

You MUST ask for explicit user confirmation before:
- Sending IM messages or mail.
- Creating, updating, or deleting tasks.
- Creating or updating calendar events.
- Creating or modifying docs, wiki pages, drive files, Base records, or Sheets.
- Applying permissions or comments.

## Execution Rules
- When proposing writes, present the exact planned changes (e.g., JSON payload or Markdown text) to the user first.
- For draft workflows (like `mail-check`), explicitly save as drafts and NEVER send automatically.
- Do not apply destructive operations (delete/archive) without triple-confirming the intent.
