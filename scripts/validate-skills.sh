#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"

failures=0

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  failures=$((failures + 1))
}

skill_files=()
while IFS= read -r file; do
  skill_files+=("$file")
done < <(find skills -mindepth 2 -maxdepth 2 -name SKILL.md | sort)

if [[ ${#skill_files[@]} -eq 0 ]]; then
  fail "no skills/*/SKILL.md files found"
fi

seen_names_file="$(mktemp "${TMPDIR:-/tmp}/lark-skill-names.XXXXXX")"
trap 'rm -f "$seen_names_file"' EXIT

for file in "${skill_files[@]}"; do
  dir="$(basename "$(dirname "$file")")"

  if ! sed -n '1p' "$file" | grep -qx -- '---'; then
    fail "$file missing opening YAML frontmatter delimiter"
    continue
  fi

  if ! sed -n '2,20p' "$file" | grep -q '^---$'; then
    fail "$file missing closing YAML frontmatter delimiter in first 20 lines"
  fi

  name="$(sed -n '2,20p' "$file" | sed -n 's/^name:[[:space:]]*//p' | head -1)"
  description="$(sed -n '2,20p' "$file" | sed -n 's/^description:[[:space:]]*//p' | head -1)"

  if [[ -z "$name" ]]; then
    fail "$file missing frontmatter name"
  elif [[ "$name" != "$dir" ]]; then
    fail "$file name '$name' does not match directory '$dir'"
  fi

  if [[ -z "$description" ]]; then
    fail "$file missing frontmatter description"
  elif [[ ${#description} -lt 40 ]]; then
    fail "$file description is too short to be trigger-oriented"
  fi

  if [[ -n "$name" ]]; then
    existing="$(awk -F '\t' -v name="$name" '$1 == name { print $2; exit }' "$seen_names_file")"
    if [[ -n "$existing" ]]; then
      fail "duplicate skill name '$name' in $file and $existing"
    fi
    printf '%s\t%s\n' "$name" "$file" >> "$seen_names_file"
  fi

  if grep -nE '^\|.*\|$' "$file" >/dev/null; then
    fail "$file contains Markdown table rows; use lists for Lark rendering"
  fi

  if grep -nE '数据来源与覆盖说明|资料索引与覆盖说明|数据覆盖|来源索引' "$file" >/dev/null; then
    fail "$file contains a fixed source/data coverage output section"
  fi

  if grep -niE '(^|[^a-z])(send|create|update|delete|archive) (messages?|mail|emails?|tasks?|docs?|files?|records?|events?) automatically|automatically (send|create|update|delete|archive)|without (user )?confirmation|无需确认.*(发送|创建|更新|删除)' "$file" | grep -viE 'never|do not|don'\''t|without explicit|before|ask' >/dev/null; then
    fail "$file may allow unsafe automatic writes"
  fi
done

if grep -RInE 'references/(reports|planning|assistant|growth)|references/setup\.md' skills AGENTS.md README.md 2>/dev/null; then
  fail "stale workflow reference path found"
fi

if find . -type f \
  -not -path './.git/*' \
  -not -path './scripts/validate-skills.sh' \
  -print0 | xargs -0 grep -InE '(/Users/[^ `]+|app_secret|secret_key|password|AKIA[0-9A-Z]{16}|sk-[A-Za-z0-9_-]{20,}|BEGIN (RSA|OPENSSH|PRIVATE) KEY)' >/dev/null; then
  fail "possible local path or secret found"
fi

if [[ $failures -gt 0 ]]; then
  printf '\n%d validation failure(s).\n' "$failures" >&2
  exit 1
fi

printf 'OK: validated %d skill(s).\n' "${#skill_files[@]}"
