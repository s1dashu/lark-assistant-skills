# lark-assistant-skills

Agent Skills for Lark/Feishu personal assistant workflows.

This repository contains a collection of independent `lark-*` skills for work planning, reporting, meeting preparation, mailbox triage, project summaries, and knowledge capture. Each workflow is packaged as its own `SKILL.md` so hosts that expose skills as slash commands can provide command entries such as `/lark-daily-report` and `/lark-monthly-report`.

## Requirements

- A compatible Agent Skills host.
- `lark-cli` installed and authenticated for the Lark/Feishu tenant you want to use.
- User identity access for personal context workflows.

Most workflows expect Lark context to be read as the user:

```bash
lark-cli auth login --domain calendar,task,docs,drive,im,mail,vc,minutes,okr
```

## Skills

| ✅ Command | Chinese Alias | What it does |
|-----------|---------------|--------------|
| **⚙️ Setup** | | |
| `/lark-setup` | `/设置` `初始化助手` `配置助手` | Initialize data-source scope, privacy boundaries, output destinations, and notification policy. |
| **📝 Reports** | | |
| `/lark-daily-report` | `/日报` `今日工作总结` `昨天日报` | Generate a daily work report. |
| `/lark-weekly-report` | `/周报` `本周总结` `上周周报` | Generate a weekly work report. |
| `/lark-monthly-report` | `/月报` `本月总结` | Generate a monthly work report. |
| `/lark-half-year-review` | `/半年总结` `年中总结` | Generate a half-year work review. |
| `/lark-annual-review` | `/全年总结` `年终总结` | Generate an annual work review. |
| `/lark-okr-review` | `/OKR复盘` | Review OKR progress and alignment. |
| **📅 Planning** | | |
| `/lark-today-plan` | `/今日规划` `今天做什么` | Plan today's work. |
| `/lark-tomorrow-plan` | `/明日规划` `明天做什么` | Plan tomorrow's work. |
| `/lark-weekly-plan` | `/本周规划` `下周规划` | Plan the week's priorities. |
| `/lark-monthly-plan` | `/本月规划` `下月规划` | Plan the month's priorities. |
| **🤖 Assistant Workflows** | | |
| `/lark-meeting-brief` | `/会前简报` `会议准备` | Prepare a pre-meeting briefing. |
| `/lark-meeting-minutes` | `/会议纪要` | Extract single-meeting minutes and follow-ups. |
| `/lark-project-summary` | `/项目总结` `项目回顾` | Summarize a project from scattered Lark artifacts. |
| `/lark-mail-check` | `/邮箱检查` `邮件检查` | Triage mailbox into actionable categories. |
| `/lark-knowledge-capture` | `/知识沉淀` `文档沉淀` | Capture scattered context into a durable knowledge document. |
| **📈 Growth** | | |
| `/lark-work-diagnosis` | `/工作诊断` `工作状态分析` | Diagnose the work system (load, cadence, ownership, blockers). |

For broad host compatibility, use the English `lark-*` command names as the stable skill names. Chinese aliases are model-routing hints and may not be recognized by all hosts.

## Installation

Use your Agent Skills host's installer if it supports repositories with a `skills/*/SKILL.md` layout.

For hosts that support `npx skills add`, install the collection from the repository:

```bash
npx skills add <repo-url>
```

To install a single skill from a repository path when your host supports path selection, target the specific skill directory:

```bash
npx skills add <repo-url>/skills/lark-weekly-report
```

Replace `<repo-url>` with the Git URL or package URL used by your host.

Manual installation is also possible by copying the desired skill directories into your host's skills directory. For example, install all skills by copying:

```text
skills/lark-*/
```

The repository is intentionally structured so each command skill can run from its own `SKILL.md` without requiring a separate router skill. If you install only one command skill, shared references under `skills/lark-assistant-skills/references/common/` are optional; the command skill still contains its required workflow steps.

## Configuration

Run `/lark-setup` first to define preferred data sources, privacy boundaries, output destinations, notification policy, and writing behavior.

The recommended local configuration path is:

```text
~/.lark-assistant.json
```

When this file exists, skills should read it before data collection and obey configured privacy boundaries, source scope, output destinations, report style, and notification policy.

## Safety Defaults

- Use `--as user` for personal context unless the user explicitly requests bot-owned resources.
- Ask before sending messages or mail.
- Ask before creating, updating, or deleting tasks, calendar events, docs, files, Base records, Sheets, Wiki pages, approvals, or permissions.
- Do not broad-scrape IM or mail by default.
- Do not add a fixed "data sources" section to final outputs. Mention data gaps only when they materially affect the answer.
- Do not use Markdown tables in final outputs because Lark IM and some Markdown renderers handle tables poorly.

## Development

Run the validation script before publishing changes:

```bash
bash scripts/validate-skills.sh
```

The validator checks required frontmatter, skill name/directory consistency, duplicate names, Markdown tables, stale reference paths, and unsafe auto-write language.

Generated local report artifacts such as `weekly_report.md` are ignored by `.gitignore` and are not part of the published skill package.

## License

MIT. See `LICENSE`.
