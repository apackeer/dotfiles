#!/usr/bin/env bash
# PreToolUse hook: Block Read on files > 2000 lines unless offset/limit is set.
# Stdin: JSON with tool_input.file_path, tool_input.limit, tool_input.offset

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
LIMIT=$(echo "$INPUT" | jq -r '.tool_input.limit // empty')
OFFSET=$(echo "$INPUT" | jq -r '.tool_input.offset // empty')

# If offset or limit is already set, the read is chunked — allow it
if [ -n "$LIMIT" ] || [ -n "$OFFSET" ]; then
  exit 0
fi

# If file doesn't exist or path is empty, let the Read tool handle the error
if [ -z "$FILE" ] || [ ! -f "$FILE" ]; then
  exit 0
fi

# Skip binary files (images, PDFs, compiled objects, etc.)
MIME=$(file --mime-type -b "$FILE" 2>/dev/null)
case "$MIME" in
  text/*|application/json|application/xml|application/javascript|application/x-ndjson)
    # Text file — proceed with line count check
    ;;
  *)
    # Binary or unknown — skip
    exit 0
    ;;
esac

# Count lines and block if over threshold
LINES=$(wc -l < "$FILE" 2>/dev/null | tr -d ' ')
if [ -n "$LINES" ] && [ "$LINES" -gt 2000 ]; then
  MSG="This file has $LINES lines (exceeds 2000-line limit). Use offset and limit to read in chunks:"
  CHUNK=1
  START=1
  while [ "$START" -le "$LINES" ]; do
    MSG="$MSG
  Chunk $CHUNK: offset=$START, limit=2000"
    CHUNK=$((CHUNK + 1))
    START=$((START + 2000))
  done
  echo "$MSG" >&2
  exit 2
fi

exit 0
