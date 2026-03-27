# Tmux

## Key Commands

Start a new session

```shell
tmux new -s NewSession
```

Exit session

```shell
tmux detach
```

List sessions

```shell
tmux ls
```

Go back into session

```shell
tmux attach -t NewSession
```

Show all available options

```shell
tmux show-options -g
```

Show all available shortcuts

```shell
tmux list-keys
```

Show all available commands

```shell
tmux list-commands
```

Start fresh

```shell
tmux kill-server && rm -rf /tmp/tmux-*
```

Enable plugins

```shell
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

## Essential Shortcuts

- Prefix: `CTRL + b`
- Reload config: `Prefix + r`
- Detach: `Prefix + d`

### Windows

- New window (in CWD): `Prefix + c`
- Navigate to window: `Prefix + number`
- Cycle through windows: `Prefix + n/p`
- Kill window (with confirmation): `Prefix + w`
- List windows/sessions: `Prefix + W` (Shift+w)
- Rename window: `Prefix + ,`

### Sessions

- Rename session: `Prefix + $`
- Explore sessions: `Prefix + s`
- Save session: `Prefix + CTRL + s` (resurrect)
- Restore session: `Prefix + CTRL + r` (resurrect)

### Panes

- Split horizontally (in CWD): `Prefix + \`
- Split vertically (in CWD): `Prefix + -`
- Navigate between panes: `CTRL + h/j/k/l` (vim-tmux-navigator)
- Resize pane: `Prefix + h/j/k/l`
- Maximize/restore pane: `Prefix + m`
- Equalize panes: `Prefix + =`
- Kill pane: `Prefix + x`

### Floating Popups

- Yazi file manager: `Prefix + CTRL + y`
- Floating terminal: `Prefix + CTRL + t`
- Lazygit: `Prefix + CTRL + g`
- Lazydocker: `Prefix + CTRL + d`

### Plugins

- Install plugins: `Prefix + I`
- **Note:** After `Prefix + I`, re-run `./scripts/symlinks.sh --create` to restore custom scripts in `plugins/tmux/scripts/` (TPM overwrites them on update)

## Copy Mode

- Enter copy mode: `Prefix + [`
- Start selection: `v`
- Copy selection: `y` (copies to system clipboard via pbcopy)
- Copy with Cmd+C: works via Ghostty keybind (copies and exits copy mode)
- Paste: `Prefix + P`
- Mouse drag selects text without exiting copy mode

## Useful Snippets

Add this to you `.zshrc` to always work in a Tmux session:

```shell
# Always work in a tmux session if Tmux is installed
if which tmux 2>&1 >/dev/null; then
  if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    tmux attach -t default || tmux new -s default; exit
  fi
fi
```
