# Modern CLI replacements
alias ls="eza --icons"
alias ll="eza -l --icons --git"
alias la="eza -la --icons --git"
alias lt="eza --tree --icons --level=2"
alias cat="bat --paging=never"

# Editor
alias vi="nvim"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Homebrew
alias bu="brew update && brew upgrade && brew cleanup"

# Network
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias listening="sudo lsof -i -n -P | grep -E 'LISTEN|UDP' | awk '{print \$1,\$2,\$3,\$8,\$9}'"

# Docker
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dstop='docker stop $(docker ps -a -q)'
alias dclean='docker system prune -a'
