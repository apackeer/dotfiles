export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="less -FMRiX"

# History (OMZ sets HIST_EXPIRE_DUPS_FIRST, HIST_VERIFY, SHARE_HISTORY, EXTENDED_HISTORY)
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Solarized LS_COLORS for tools that use it (fzf, fd, tab completion, etc.)
if command -v gdircolors &>/dev/null && [[ -f ~/.dir_colors ]]; then
  eval "$(gdircolors -b ~/.dir_colors)"
fi

# Eza — 24-bit solarized dark theme via ~/.config/eza/theme.yml
# EZA_COLORS overrides LS_COLORS file-type codes so theme.yml isn't clobbered
export EZA_CONFIG_DIR="$HOME/.config/eza"
export EZA_COLORS="reset:\
di=1;38;2;38;139;210:\
ln=38;2;42;161;152:\
or=38;2;220;50;47:\
ex=38;2;133;153;0:\
fi=38;2;131;148;150:\
so=38;2;88;110;117:\
pi=38;2;88;110;117:\
bd=38;2;181;137;0:\
cd=38;2;181;137;0:\
su=38;2;220;50;47:\
sg=38;2;220;50;47:\
tw=1;38;2;38;139;210:\
ow=1;38;2;38;139;210"

# Bun
export BUN_INSTALL="$HOME/.bun"
