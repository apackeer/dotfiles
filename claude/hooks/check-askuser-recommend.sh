#!/usr/bin/env bash
# PreToolUse hook: Enforce the "always recommend" rule on AskUserQuestion.
# Every question's options[0].label must contain "(Recommended)", OR some
# option label must contain "(Toss-up)" (the explicit no-preference escape).
# Stdin: JSON with tool_input.questions[].options[].label

INPUT=$(cat)

command -v jq >/dev/null 2>&1 || exit 0

FAILING=$(echo "$INPUT" | jq -r '
  [ .tool_input.questions[]?
    | select(
        (((.options[0].label // "") | contains("(Recommended)"))
         or ([.options[]? | (.label // "")] | any(contains("(Toss-up)"))))
        | not
      )
    | .question
  ] | join(" | ")')

if [ -n "$FAILING" ]; then
  cat >&2 <<EOF
BLOCKED: AskUserQuestion violates the always-recommend rule for: $FAILING
Fix before resending: put your recommended option FIRST and include the
literal string "(Recommended)" in that option's label (not just in prose),
with the reasoning in its description. If it is genuinely a toss-up (rare),
include "(Toss-up)" in the first option's label and explain why neither wins.
EOF
  exit 2
fi

exit 0
