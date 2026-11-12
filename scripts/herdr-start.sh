#!/bin/zsh

set -u

readonly herdr_bin="/opt/homebrew/bin/herdr"

# No herdr on this machine: open a normal login shell so the terminal still works.
if [[ ! -x "$herdr_bin" ]]; then
  exec "${SHELL:-/bin/zsh}" -l
fi

exec "$herdr_bin" "$@"
