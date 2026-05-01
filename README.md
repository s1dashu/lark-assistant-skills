# lark-assistant-skills

Agent Skills for Lark/Feishu personal assistant workflows.

This repository contains a collection of independent `lark-*` skills for work planning, reporting, meeting preparation, mailbox triage, project memory, and work coaching. Each workflow is packaged as its own `SKILL.md` so hosts that expose skills as slash commands can provide command entries such as `/lark-daily-report` and `/lark-monthly-report`.

## Requirements

- A compatible Agent Skills host.
- `lark-cli` installed and authenticated for the Lark/Feishu tenant you want to use.
- User identity access for personal context workflows.

Most workflows expect Lark context to be read as the user:

```bash
lark-cli auth login --domain calendar,task,docs,drive,im,mail,vc,minutes,okr
```

## Skills

Setup:
- `/lark-setup`: initialize data-source scope, privacy boundaries, output destinations, and notification policy.

Reports:
- `/lark-daily-report`: daily report.
- `/lark-weekly-report`: weekly report.
- `/lark-monthly-report`: monthly report.
- `/lark-half-year-review`: half-year review.
- `/lark-annual-review`: annual review.
- `/lark-okr-review`: OKR progress and alignment review.

Planning:
- `/lark-today-plan`: today's plan.
- `/lark-tomorrow-plan`: tomorrow's plan.
- `/lark-weekly-plan`: weekly plan.
- `/lark-monthly-plan`: monthly plan.

Assistant workflows:
- `/lark-meeting-brief`: pre-meeting briefing.
- `/lark-meeting-minutes`: single-meeting minutes and follow-up extraction.
- `/lark-project-summary`: project summary.
- `/lark-mail-check`: mailbox triage.
- `/lark-document-memory`: durable document memory.
- `/lark-message-watch`: recent message and mail monitoring.

Growth:
- `/lark-work-diagnosis`: diagnose the work system.
- `/lark-work-coach`: professional work coaching.
- `/lark-emotional-support`: non-clinical emotional support.

Chinese aliases such as `/日报`, `/月报`, `/今日规划`, and `/工作诊断` are documented inside the relevant skills as model-routing aliases. For broad host compatibility, use the English `lark-*` command names as the stable skill names.

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
