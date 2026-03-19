typeset -U path

path=(
  /opt/homebrew/opt/coreutils/libexec/gnubin
  $BUN_INSTALL/bin
  $HOME/.local/bin
  $HOME/bin
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  $path
)
