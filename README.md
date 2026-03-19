# Dotfiles

My config files for maintaining a consistent dev environment across machines.

## Essential Tools

- **Editor**: [NeoVim](https://neovim.io/) with lazy.nvim, LSP, Treesitter, Telescope, and Neo-tree
- **Multiplexer**: [Tmux](https://github.com/tmux/tmux/wiki) with resurrect, continuum, and Solarized Dark theme
- **Terminal**: [Ghostty](https://ghostty.org/)
- **Shell**: [Zsh](https://www.zsh.org/) with [Powerlevel10k](https://github.com/romkatv/powerlevel10k) prompt
- **Color Theme**: [Solarized Dark](https://ethanschoonover.com/solarized/) across all tools
- **Window Management**: [Moom](https://manytricks.com/moom/)
- **File Manager**: [Path Finder](https://www.cocoatech.io/)
- **Launcher**: [Alfred](https://www.alfredapp.com/) with custom workflows

## Setup

Clone the repo and run the installer:

```bash
git clone git@github.com:apackeer/dotfiles.git ~/src/dotfiles
cd ~/src/dotfiles
./install.sh
```

Follow the interactive prompts to create symlinks and apply macOS defaults.

**Note:** Git user config is not tracked. After installing, create `~/.config/git/config.local`:

```gitconfig
[user]
    name = Your Name
    email = you@example.com
```

## Uninstalling

Remove all symlinks:

```bash
./scripts/symlinks.sh --delete
```

This only removes the symlinks, not the actual config files, so you can easily revert if needed.

## Adding New Dotfiles

1. Add config files under the appropriate tool directory (e.g., `tool/config`)
2. Add a mapping to `symlinks.conf` in the format `$DOTFILES_DIR/source : $HOME/target`
3. Run `./scripts/symlinks.sh --create` to apply

## Structure

```
dotfiles/
├── install.sh          # Interactive setup script
├── symlinks.conf       # Source:target symlink mappings
├── scripts/
│   ├── utils.sh        # Colored logging helpers
│   ├── symlinks.sh     # Create/delete symlinks
│   └── macos.sh        # macOS system defaults
├── ghostty/            # Ghostty terminal config
├── tmux/               # Tmux config
├── nvim/               # NeoVim config (lazy.nvim)
├── zsh/                # Zsh config + modules
├── git/                # Git config
└── alfred/             # Alfred workflows
```

## Acknowledgements

Repo structure and scripts inspired by [hendrikmi/dotfiles](https://github.com/hendrikmi/dotfiles).

