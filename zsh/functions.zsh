# mkdir + cd
mkd() { mkdir -p "$@" && cd "$@" }

# Start HTTP server
serve() { python3 -m http.server "${1:-8000}" }

# File/directory size
fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh
  else
    local arg=-sh
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* *
  fi
}

# Gzip comparison
gz() {
  echo "orig size (bytes): "
  cat "$1" | wc -c
  echo "gzipped size (bytes): "
  gzip -c "$1" | wc -c
}

# DNS lookup
digga() { dig +nocmd "$1" any +multiline +noall +answer }

# Pretty-print JSON
json() {
  if [ -t 0 ]; then
    echo "$*" | jq .
  else
    jq .
  fi
}
