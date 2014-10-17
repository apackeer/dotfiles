# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Look in ~/.oh-my-zsh/themes/
ZSH_THEME="robbyrussell"

# Load Boxen environment (needed for homebrew paths etc)
if [ -f /opt/boxen/env.sh ]; then
  . /opt/boxen/env.sh
fi

# Exports
if [ -f ~/.exports ]; then
    source ~/.exports
fi

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git virtualenv virtualenvwrapper)

# Oh-my-zsh settings
if [ -f  $ZSH/oh-my-zsh.sh ]; then
    source $ZSH/oh-my-zsh.sh
fi

# Setup Solarized dircolors
if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
    eval `gdircolors ~/.dir_colors`
fi

# autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# Grab aliases
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# Functions
if [ -f ~/.functions ]; then
    source ~/.functions
fi

# Initialize rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# GRC
source "`brew --prefix`/etc/grc.bashrc"
