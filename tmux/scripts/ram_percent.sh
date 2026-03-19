#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8

total=$(sysctl -n hw.memsize)
page_size=$(pagesize)
used=$(vm_stat | awk -v ps="$page_size" '
  /Pages active/                { a = $3+0 }
  /Pages wired/                 { w = $4+0 }
  /occupied by compressor/      { c = $5+0 }
  END { print (a + w + c) * ps }
')
pct=$((used * 100 / total))
echo "󰍛 ${pct}%"
