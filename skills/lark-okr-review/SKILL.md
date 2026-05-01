---
name: lark-okr-review
description: Review Lark/Feishu OKR progress, alignment, risks, and next actions. Use when the user asks for OKR review, OKR 复盘, 目标进展, 目标对齐, or /OKR复盘.
---

# Lark OKR Review

Review the user's OKR cycle and produce an evidence-aware progress summary with risks, alignment gaps, and recommended next actions.

Chinese aliases: `/OKR复盘`, `/目标复盘`, `OKR 进展`, `目标对齐`.

## Preconditions

- Use `--as user` for personal OKR context unless the user explicitly requests bot-owned resources.
- If `~/.lark-assistant.json` exists, read it first and obey configured privacy boundaries, source scope, timezone, output destination, and report style.
- If this collection is installed as a whole, follow `../lark-assistant-skills/references/common/config-schema.md` and `../lark-assistant-skills/references/common/reporting-standards.md` for shared configuration, source-scope, synthesis, and safety guidance. This skill remains usable without those references.
- Ask before creating tasks, sending messages, updating docs, or writing OKR-related records.

## Window

Default to the active OKR cycle. If the user names a quarter, half-year, year, or custom period, resolve that period in the configured timezone.

For `--time-range`, use the CLI format `YYYY-MM--YYYY-MM`.

## Data Collection

Start with OKR structure:

```bash
lark-cli okr +cycle-list --as user --time-range "<YYYY-MM--YYYY-MM>" --format json
lark-cli okr +cycle-detail --as user --cycle-id "<cycle_id>" --format json
```

If the user asks about a specific person and provides an ID, or a previous step resolves the user ID:

```bash
lark-cli okr +cycle-list --as user --user-id "<user_id>" --user-id-type "<open_id|union_id|user_id>" --time-range "<YYYY-MM--YYYY-MM>" --format json
```

Use supporting evidence only where it helps explain progress or risk:

```bash
lark-cli task +get-my-tasks --as user --format json --page-all
lark-cli docs +search --as user --query "<objective_or_project_keyword>" --format json --page-size 10
lark-cli vc +search --as user --query "<objective_or_project_keyword>" --start "<period_start_date>" --end "<period_end_date>" --format json --page-size 10
```

Do not search IM or mail by default. Use them only when requested, configured, or necessary to resolve a named dependency or escalation.

## Synthesis Rules

- Treat OKR fields as the source of truth for objective, KR, progress, owner, and alignment metadata.
- Separate objective health from execution activity. Busy work is not progress unless it moves a KR.
- For each objective, identify current status, evidence, blockers, owner/dependency, and next action.
- Distinguish facts from interpretation. Use `低可信` when a risk is inferred only from sparse tasks or meeting titles.
- Highlight alignment gaps: KRs without clear work evidence, active projects not mapped to any OKR, or objectives with no recent signals.
- Do not rewrite or update OKRs without explicit confirmation.

## Output

```md
# OKR 复盘（[Cycle/Period]）

## 总体判断
用 1 个自然段总结本周期 OKR 的整体健康度、最关键进展、最大风险和是否需要调整重点。

## 目标进展
### [Objective]
1. **当前状态**: [正常 / 有风险 / 偏离 / 信息不足]
2. **关键结果进展**: [概述 KR 进度和证据]
3. **支撑工作**: [任务、文档、会议或交付物证据]
4. **风险与依赖**: [说明 blocker、依赖方或不确定性]
5. **建议动作**: [下一步行动、owner、时间点]
6. **可信度**: 高 / 中 / 低

## 对齐问题
1. **[Gap]**: [说明目标、工作或依赖之间的不一致]

## 下阶段建议
1. **继续推进**: ...
2. **需要补证据/补计划**: ...
3. **建议调整或对齐**: ...
```

Ask before creating follow-up tasks, sending alignment messages, or updating any OKR-related doc.
