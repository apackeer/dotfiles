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

# Docker (Colima)
alias dup="colima start"
alias ddown="colima stop"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dlog="docker logs -f"
alias dexec="docker exec -it"
alias dstop='docker stop $(docker ps -a -q)'
alias drm='docker rm $(docker ps -a -q)'
alias dclean="docker system prune -a"
alias dim="docker images"
alias dctx="docker context use"  # dctx colima | dctx desktop-linux (ECR)
alias lzd="lazydocker"

# Browser
alias chrome-debug='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222 --user-data-dir=$HOME/.chrome-debug'
