# IM Messages Guide

Best practices for fetching and using Feishu IM messages as a primary data source for reports, planning, and work diagnosis.

## Why IM Messages Are Critical

Calendar events and meeting titles **cannot** tell you who actually drove a decision. Docs and tasks show outcomes but miss the real-time negotiation. IM messages reveal:

- Who was @mentioned for decisions vs. who was merely in a meeting
- What the user actually said vs. what meetings they were invited to
- Real-time priority shifts, blockers, and owner changes
- Passive attendance vs. active contribution

**Rule**: For weekly reports, planning, and work diagnosis, always read IM messages. Do not rely on calendar RSVP alone to judge work ownership.

## Fetching Messages

### Primary Command

```bash
# Messages sent by the user
lark-cli im +messages-search --as user --sender <user_open_id> --start "<iso>" --end "<iso>" --page-size 50 --format json

# Messages that @mention the user
lark-cli im +messages-search --as user --is-at-me --start "<iso>" --end "<iso>" --page-size 50 --format json
```

### User Open ID

Get the user's open_id from auth status:

```bash
lark-cli auth status --format json | jq -r '.userOpenId'
```

### Pagination — Critical

IM search results almost always span multiple pages. **Always paginate exhaustively** before summarizing. A single page of 20–50 messages is rarely enough.

**Correct pattern** (save full JSON per page, extract token from JSON):

```bash
# Page 1
lark-cli im +messages-search ... --page-size 50 --format json > page1.json
TOKEN=$(jq -r '.data.page_token' page1.json)

# Page 2
lark-cli im +messages-search ... --page-size 50 --page-token "$TOKEN" --format json > page2.json
TOKEN=$(jq -r '.data.page_token' page2.json)

# Continue until .data.has_more is false
```

**Wrong pattern** (do NOT do this):

```bash
# BAD: piping through `head` truncates JSON and drops page_token
lark-cli im +messages-search ... --format json | head -200
# BAD: copying a token from a different API call (e.g., docs +search)
lark-cli im +messages-search ... --page-token "$DOCS_TOKEN"
```

### Page Token Length by API

| API | Typical token length | Reason |
|-----|---------------------|--------|
| `im +messages-search` | ~16 chars | Simple offset/cursor |
| `docs +search` | 1500–2000 chars | Distributed search across geo regions (eu_ea, eu_nc, larkmy, larksgaws, useast15a) |

**Never mix tokens across APIs.** A `docs +search` token is not valid for `im +messages-search`.

### Safe Token Handling

Long tokens or tokens with special characters can break shell command-line parsing. Always:

1. Extract token from JSON using `jq`
2. Store in a shell variable
3. Pass via `--page-token "$TOKEN"` (quoted)

Do not paste tokens directly into long command strings.

## Analyzing Messages

### Chat Distribution Analysis

After collecting all pages, group by chat_name to find where the user is most active:

```bash
jq -s '[.[].data.messages[] | {chat_name}] | group_by(.chat_name) | map({chat: .[0].chat_name, count: length}) | sort_by(-.count)'
```

### Sent vs. @Me Comparison

| Direction | What it reveals |
|-----------|----------------|
| **User sent** | What the user actively pushed, decided, or clarified |
| **@Me** | Where others treat the user as a decision owner or blocker |

Both are needed. A user who sends few messages but is heavily @mentioned may be a bottleneck. A user who sends many messages but is rarely @mentioned may be pushing work that others are not engaging with.

### Evidence Hierarchy for Work Ownership

1. **User organized a meeting** → Strong evidence of ownership
2. **User was @-mentioned for a decision** → Strong evidence of ownership
3. **User sent messages proposing/summing up decisions** → Strong evidence of ownership
4. **User attended a meeting (RSVP accept)** → Weak evidence; may be passive attendance
5. **User's calendar shows a busy block** → No evidence of contribution

## Common Pitfalls

| Pitfall | Why it happens | Fix |
|---------|---------------|-----|
| `head` truncates JSON | Pipe to `head -N` cuts mid-object | Save full output to file, use `jq` to extract fields |
| Mixed API tokens | Accidentally reuse a `docs` token for `im` | Track tokens per-API, label variables clearly |
| Stopping at page 1 | Assuming 50 messages is enough | Always check `has_more`, continue until false |
| Shell quoting breaks long tokens | Special chars in token | Use variables with double quotes: `--page-token "$TOKEN"` |
| Missing p2p chats | Forgetting private conversations | Include both `--sender` and `--is-at-me` queries |

## Performance Notes

- `im +messages-search` supports `--as user` only (not bot)
- Page size range: 1–50
- Time range should include timezone offset: `2026-04-27T00:00:00+08:00`
- For long windows (monthly, half-year reports), consider narrowing with `--chat-id` or keyword `--query` first to reduce result volume
