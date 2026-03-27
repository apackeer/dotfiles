# Ctrl+F for fzf history search (both insert and normal vi modes)
bindkey -M viins '^F' fzf-history-widget
bindkey -M vicmd '^F' fzf-history-widget

# Ctrl+G for interactive grep (like <leader>sg in Neovim)
fzf-grep-widget() {
  local result
  result=$(rg --line-number --color=always '' \
    | fzf --ansi --delimiter ':' \
          --preview 'bat --color=always --highlight-line {2} {1}' \
          --preview-window '+{2}-5')
  if [[ -n "$result" ]]; then
    local file line
    file=$(echo "$result" | cut -d: -f1)
    line=$(echo "$result" | cut -d: -f2)
    ${EDITOR:-nvim} "+$line" "$file"
  fi
  zle reset-prompt
}
zle -N fzf-grep-widget
bindkey -M viins '^G' fzf-grep-widget
bindkey -M vicmd '^G' fzf-grep-widget

# mkdir + cd
mkd() { mkdir -p "$@" && cd "$1" }

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
  wc -c < "$1"
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
