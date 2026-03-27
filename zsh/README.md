# Zsh

Modular zsh config built on [Oh My Zsh](https://ohmyz.sh/) with [Powerlevel10k](https://github.com/romkatv/powerlevel10k) prompt.

## Module Loading Order

Loaded from `.zshrc` in this order:

1. `p10k.zsh` instant prompt (must be first)
2. `plugins.zsh` + Oh My Zsh init
3. `exports.zsh` - Environment variables
4. `paths.zsh` - PATH additions
5. `aliases.zsh` - Shell aliases
6. `functions.zsh` - Custom shell functions
7. `completions.zsh` - Tab completion settings
8. `tools.zsh` - Tool initialization (mise)
9. `amazon.zsh` - Work config (optional, not tracked)
10. `syntax-highlighting.zsh` - zsh-syntax-highlighting setup
11. `~/.env.secrets` - API keys/tokens (optional, not tracked)

## Plugins

Via Oh My Zsh:

| Plugin | Purpose |
|--------|---------|
| `git` | Git aliases and completions |
| `vi-mode` | Vim keybindings for the command line |
| `fzf` | Fuzzy finder integration (`Ctrl+F` history, `Ctrl+G` grep) |
| `zoxide` | Smart `cd` replacement |
| `history-substring-search` | Search history by substring |
| `docker` | Docker completions |
| `kubectl` | Kubernetes completions |
| `npm` | npm completions |
| `zsh-autosuggestions` | Fish-like autosuggestions |
| `zsh-syntax-highlighting` | Command syntax highlighting |

## Vi Mode

Vim keybindings are enabled for the command line. Cursor changes shape to indicate mode.

| Key | Action |
|-----|--------|
| `Esc` | Switch to normal mode (block cursor) |
| `i` / `a` | Switch to insert mode (beam cursor) |
| `A` | Insert at end of line |
| `I` | Insert at start of line |
| `w` / `b` | Move forward/back by word |
| `0` / `$` | Start/end of line |
| `d`, `c`, `f`, etc. | Vim motions work as expected |

### Autosuggestions in Vi Mode

| Key | Mode | Action |
|-----|------|--------|
| `l` | Normal | Accept suggestion one character at a time |
| `Ctrl+Space` | Insert/Normal | Accept full suggestion |
| `Right arrow` | Insert/Normal | Accept full suggestion |

## Aliases

### Modern CLI Replacements

| Alias | Command | Description |
|-------|---------|-------------|
| `ls` | `eza --icons` | File listing with icons |
| `ll` | `eza -l --icons --git` | Long listing with git status |
| `la` | `eza -la --icons --git` | Long listing including hidden |
| `lt` | `eza --tree --icons --level=2` | Tree view (2 levels) |
| `cat` | `bat --paging=never` | Syntax-highlighted file viewer |
| `vi` | `nvim` | Neovim as default editor |

### Navigation

| Alias | Description |
|-------|-------------|
| `..` | Up one directory |
| `...` | Up two directories |
| `....` | Up three directories |

### Homebrew

| Alias | Description |
|-------|-------------|
| `bu` | Update, upgrade, and cleanup Homebrew |

### Network

| Alias | Description |
|-------|-------------|
| `ip` | Public IP address |
| `localip` | Local IP address (en0) |
| `listening` | Show listening ports |

### Docker (Colima)

| Alias | Description |
|-------|-------------|
| `dup` / `ddown` | Start / stop Colima |
| `dps` / `dpsa` | List containers (running / all) |
| `dlog` | Follow container logs |
| `dexec` | Exec into container |
| `dstop` / `drm` | Stop / remove all containers |
| `dclean` | Prune all Docker resources |
| `dim` | List images |
| `dctx` | Switch Docker context |
| `lzd` | Launch lazydocker |

## Functions

| Function | Description |
|----------|-------------|
| `mkd` | Create directory and cd into it |
| `serve` | Start Python HTTP server (default port 8000) |
| `fs` | Show file/directory sizes |
| `gz` | Compare original vs gzipped size |
| `digga` | DNS lookup (any record type) |
| `json` | Pretty-print JSON via jq |
| `fzf-grep-widget` | Interactive ripgrep + fzf, opens match in `$EDITOR` (`Ctrl+G`) |

## Key Settings

| Setting | Value |
|---------|-------|
| Editor | `nvim` |
| History size | 50,000 entries |
| History behavior | Deduplicated, shared across sessions, timestamped |
| Runtime manager | mise (via `tools.zsh`) |

## File Structure

```
zsh/
├── .zshrc              # Main config (module loader)
├── .zprofile           # Login shell setup
├── p10k.zsh            # Powerlevel10k prompt config
├── plugins.zsh         # Oh My Zsh plugin list + vi-mode config
├── exports.zsh         # Environment variables
├── paths.zsh           # PATH additions
├── aliases.zsh         # Shell aliases
├── functions.zsh       # Custom functions
├── completions.zsh     # Tab completion settings
├── tools.zsh           # Tool initialization (mise)
├── amazon.zsh          # Work-specific config (not tracked)
└── syntax-highlighting.zsh
```
