# Diagnosis Standards

Use these standards for work diagnosis, work coaching, and work-system analysis.

## Preconditions

- Use `--as user` for personal work context.
- If `~/.lark-assistant.json` exists, read it first and obey configured privacy boundaries and source scope.
- Treat diagnostics as advisory, not factual judgment.
- Avoid sensitive psychological claims; focus on observable work-system signals.

## Data Collection

**IM messages are the most important source for diagnosis.** Calendar and tasks show what happened; messages reveal how it happened — communication load, response latency, delegation patterns, bottleneck positions, and ownership shifts.

1. **IM messages** — Fetch exhaustively over the diagnosis window. See `im-messages-guide.md`.
   - Chat distribution: where does the user spend messaging energy?
   - Sent vs. @me ratio: pushing work vs. being pulled into decisions
   - Response latency: are there threads the user left unanswered?
   - Ownership language: "我来负责" vs. "可以拉个会" vs. passive silence
2. **Calendar events** — Meeting density, fragmentation, recurring vs. ad-hoc ratio.
3. **Tasks** — Aging, overdue rate, reopened tasks, completion velocity.
4. **VC records** — Meeting count and whether notes exist.
5. **Docs** — Recently created/edited documents to find active vs. dormant projects.

Do not fetch OKR or mail unless requested.

## Diagnosis Rules

- Separate evidence from inference.
- Avoid clinical or personality judgments.
- Identify passive meeting load and ownership gaps.
- Prefer system-level fixes over vague advice.
- Distinguish `用户主动发起`, `用户被动响应`, and `用户未参与`.

## Output

```md
# 工作负荷与系统诊断（[Start Date] - [End Date]）

## 诊断摘要
- ...

## 核心发现与推断
### [Issue/Pattern]
- **证据**: ...
- **推断**: ...
- **影响**: ...
- **建议**: ...

## 立刻可做的 3 个系统调整
1. ...
2. ...
3. ...
```

Ask before changing tasks, calendar, messages, mail, docs, or Base records.
