#!/usr/bin/env bash
set -euo pipefail

# Catch high-confidence leaks. A human review remains mandatory for context leaks.
root=$(git rev-parse --show-toplevel)
cd "$root"

failed=0
report() {
  printf 'Potential sensitive content: %s\n' "$1" >&2
  failed=1
}

pattern='-----BEGIN ([A-Z ]+)?PRIVATE KEY-----|\b(sk|rk|pk)-[A-Za-z0-9_-]{16,}|\bgh[pousr]_[A-Za-z0-9_]{16,}|\bAKIA[0-9A-Z]{16}\b|[Bb]earer[[:space:]]+[A-Za-z0-9._~+/-]{16,}|(api[_-]?key|access[_-]?token|refresh[_-]?token|password)[[:space:]]*[:=][[:space:]]*[^[:space:]"]{8,}|([Ss]et-[Cc]ookie|[Cc]ookie)[[:space:]]*[:=]|https?://(localhost|127\.0\.0\.1|10\.|192\.168\.|172\.(1[6-9]|2[0-9]|3[0-1])\.)|\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b|\+[0-9][0-9 ()-]{7,}[0-9]'

while IFS= read -r -d '' file; do
  case "$file" in
    *.log|*.jsonl|*chat*history*|*conversation*|*transcript*)
      report "$file (log or conversation artifact)"
      continue
      ;;
  esac

  set +e
  matches=$(grep -I -n -E -e "$pattern" "$file")
  grep_status=$?
  set -e

  if (( grep_status == 0 )); then
    printf '%s\n' "$matches" >&2
    report "$file"
    continue
  fi

  if (( grep_status != 1 )); then
    report "$file (scanner failed)"
  fi
done < <(git ls-files -co --exclude-standard -z)

if (( failed )); then
  printf '%s\n' 'Remove the data or replace it with a fictional placeholder before committing.' >&2
  exit 1
fi

printf '%s\n' 'Static sensitive-content audit passed. Complete the required human review before committing or pushing.'
