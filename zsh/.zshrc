# P10k instant prompt (must be at top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump" # Keep completion cache out of $HOME
source ~/.config/zsh/plugins.zsh
source $ZSH/oh-my-zsh.sh

# Modules
source ~/.config/zsh/exports.zsh             # Environment variables
source ~/.config/zsh/paths.zsh               # PATH additions
source ~/.config/zsh/aliases.zsh             # Shell aliases
source ~/.config/zsh/functions.zsh           # Custom shell functions
source ~/.config/zsh/completions.zsh         # Tab completion settings
source ~/.config/zsh/tools.zsh               # Tool initialization (fzf, zoxide, etc.)
[ -f ~/.config/zsh/amazon.zsh ] && source ~/.config/zsh/amazon.zsh  # Work config (not tracked)
source ~/.config/zsh/syntax-highlighting.zsh # zsh-syntax-highlighting setup

# Secrets & prompt
[ -f "$HOME/.env.secrets" ] && source "$HOME/.env.secrets" # Load API keys/tokens if present
[[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh
