---
name: lark-document-memory
description: Create a durable Lark document or knowledge-base memory from scattered context. Use when the user asks for 文档沉淀, document memory, 沉淀文档, 主题沉淀, or /文档沉淀.
---

# Lark Document Memory

Create a structured document for a concept, theme, project, or decision area from scattered Lark context.

Chinese aliases: `/文档沉淀`, `沉淀文档`, `知识沉淀`.

## Data Collection

```bash
lark-cli docs +search --as user --query "<theme>" --format json --page-size 10
lark-cli vc +search --as user --query "<theme>" --start "<start_date>" --end "<end_date>" --format json --page-size 10
```

Deep-dive:

```bash
lark-cli docs +fetch --as user --doc "<doc_token>"
lark-cli vc +notes --as user --meeting-ids "<ids>"
```

Limit message search unless specifically requested.

## Synthesis Rules

- Build a cohesive narrative, not a raw log.
- Extract facts, decisions, open questions, and next actions.
- If sources conflict, explain the evolution or latest consensus.

## Output

```md
# [Theme] 沉淀文档

## 背景与定义
- ...

## 当前共识与核心事实
- ...

## 关键决策记录
- ...

## 遗留问题与争议
- ...

## 下一步行动
- ...

```

Ask before creating or updating a Lark Doc/Wiki page.
