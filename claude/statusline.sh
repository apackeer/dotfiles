#!/bin/bash
input=$(cat)

# Parse JSON
model=$(echo "$input" | jq -r '.model.id')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // "0"')
used_pct_int=$(printf "%.0f" "$used_pct")
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
dir_name=$(basename "$current_dir")

# Model: detect Bedrock (us.anthropic. / global.anthropic. prefix), then abbreviate
prefix=""
if [[ "$model" == us.anthropic.* || "$model" == global.anthropic.* ]]; then
  prefix="BR:"
  model="${model#us.anthropic.}"
  model="${model#global.anthropic.}"
fi
model=$(echo "$model" | sed -E 's/^claude-//; s/-v[0-9]+//; s/-[0-9]{8}//; s/:[0-9]+$//')

# Effort level: append as (level) if set
effort=""
effort_level=$(echo "$input" | jq -r '.effort.level // empty')
if [ -n "$effort_level" ]; then
  effort="(${effort_level})"
fi

# Context colour: green <50%, yellow 50-74%, red >=75%
if [ "$used_pct_int" -ge 75 ]; then
  cc="\033[31m"
elif [ "$used_pct_int" -ge 50 ]; then
  cc="\033[33m"
else
  cc="\033[32m"
fi
r="\033[0m"

# Git: branch name + clean/dirty
gs=""
if git -C "$current_dir" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$current_dir" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git -C "$current_dir" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  branch=$(printf '%s' "$branch" | tr -d '\n')
  if ! git -C "$current_dir" --no-optional-locks diff --quiet 2>/dev/null || ! git -C "$current_dir" --no-optional-locks diff --cached --quiet 2>/dev/null; then
    gs=" ${branch} \033[31m✗${r}"
  else
    gs=" ${branch} \033[32m✓${r}"
  fi
fi

# Thin powerline separator (matches p10k subsegment, terminal colour 10)
s="\033[38;5;10m\033[0m"

if [ -n "$gs" ]; then
  printf '%b' "${prefix}${model}${effort} ${s} ${cc}ctx:${used_pct_int}%${r} ${s} ${dir_name} ${s} ${gs# }"
else
  printf '%b' "${prefix}${model}${effort} ${s} ${cc}ctx:${used_pct_int}%${r} ${s} ${dir_name}"
fi

# AI-DLC lead box only: a second line with the fleet and the merge queue, written each minute by
# aidlc-workflows/tmp/workshop-fixes/lead-status.sh (cron). Nothing shows where that file does not exist.
ops=/var/tmp/w9-lead-status.txt
if [[ "$current_dir" == /home/ubuntu/src/aidlc-workflows* ]] && [ -f "$ops" ]; then
  age=$(( $(date +%s) - $(stat -c %Y "$ops") ))
  if [ "$age" -gt 180 ]; then
    printf '\n%b' "\033[33mops: status ${age}s old (lead-status.sh cron)${r}"
  else
    line=$(cat "$ops")
    line=${line//bus OFF/\\033[31mbus OFF\\033[0m}
    if [[ "$line" =~ for\ you\ ([1-9][0-9]*) ]]; then line=${line//for you ${BASH_REMATCH[1]}/\\033[33mfor you ${BASH_REMATCH[1]}\\033[0m}; fi
    printf '\n%b' "$line"
  fi
fi
