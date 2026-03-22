# Vi mode config (must be set before oh-my-zsh sources the plugin)
VI_MODE_SET_CURSOR=true            # Block cursor in normal mode, beam in insert
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

plugins=(
  git
  vi-mode
  fzf
  zoxide
  history-substring-search
  docker
  kubectl
  npm
  zsh-autosuggestions
  zsh-syntax-highlighting
)
