# Lark Assistant Configuration Schema

Use `~/.lark-assistant.json` as an optional local preference file for personal-assistant workflows. If it exists, read it before collecting Lark context and obey privacy, source-scope, output, and notification settings.

The file is advisory configuration, not an authorization grant. Still confirm before sending messages, sending mail, creating or updating Lark resources, moving files, or writing records.

## Recommended Schema

```json
{
  "version": 1,
  "timezone": "Asia/Shanghai",
  "language": "zh-CN",
  "source_scope": [
    "calendar",
    "task",
    "vc",
    "minutes",
    "docs",
    "wiki",
    "okr"
  ],
  "privacy": {
    "ignore_people": [],
    "ignore_chats": [],
    "ignore_keywords": [],
    "sources_require_permission": [
      "im",
      "mail"
    ]
  },
  "output": {
    "default_destination": "im",
    "doc_folder": "",
    "wiki_space": "",
    "base_app": ""
  },
  "notification_policy": {
    "mode": "draft_only",
    "urgent_alerts": false,
    "critical_buzz": false
  },
  "style": {
    "report": "concise",
    "planning": "actionable",
    "include_appendix": false
  },
  "projects": {
    "aliases": {}
  }
}
```

## Field Rules

- `version`: Schema version. Start with `1`.
- `timezone`: IANA timezone used to resolve relative dates such as today, this week, H1, and last month.
- `language`: Preferred output language.
- `source_scope`: Sources allowed for routine collection. Skills may ask before using sources not listed here.
- `privacy.ignore_people`: Names or IDs to exclude from summaries unless explicitly requested.
- `privacy.ignore_chats`: Chat IDs, names, or aliases to exclude from broad scans.
- `privacy.ignore_keywords`: Topics, customers, projects, or keywords to exclude.
- `privacy.sources_require_permission`: Sources that require explicit per-run confirmation before reading. Recommended defaults are `im` and `mail`.
- `output.default_destination`: Preferred final output destination. Allowed values: `im`, `doc`, `wiki`, `base`, `local`.
- `output.doc_folder`, `output.wiki_space`, `output.base_app`: Optional destination IDs or URLs for save/archive workflows.
- `notification_policy.mode`: Allowed values: `draft_only`, `urgent_with_confirmation`, `critical_with_prior_authorization`.
- `notification_policy.urgent_alerts`: If true, a monitoring skill may propose an urgent IM alert, but must still confirm before sending unless the user gave explicit prior authorization.
- `notification_policy.critical_buzz`: If true, a monitoring skill may propose Lark urgent/buzz behavior, but must confirm the exact action before execution.
- `style.report`: Suggested report style. Common values: `concise`, `okr_oriented`, `management_update`, `deep_review`.
- `style.planning`: Suggested planning style. Common values: `actionable`, `time_blocked`, `priority_only`.
- `style.include_appendix`: Whether long reports should include a detailed appendix when enough evidence exists.
- `projects.aliases`: Optional map from short aliases to project names, doc links, group names, or keywords.

## Compatibility Rules

- Missing fields mean "use the skill default".
- Unknown fields should be ignored, not treated as errors.
- Do not print the full config in final user-facing output unless the user asks.
- If configuration conflicts with an explicit user request, follow the explicit request after noting any privacy or safety concern.
