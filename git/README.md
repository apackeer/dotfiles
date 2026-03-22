# Git

Global git config with [delta](https://github.com/dandavid/delta) as the diff pager.

## Diff & Merge

| Setting | Value |
|---------|-------|
| Pager | delta (side-by-side, line numbers) |
| Syntax theme | Solarized (dark) |
| Diff algorithm | histogram |
| Merge conflict style | zdiff3 |
| Rerere | Enabled (remembers conflict resolutions) |

## Push & Pull

| Setting | Value |
|---------|-------|
| Push default | `current` (push to same-named remote branch) |
| Auto setup remote | Enabled (no need for `-u` on first push) |
| Pull strategy | Rebase |

## Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `s` | `status -s` | Short status |
| `l` | `log --pretty=oneline -n 20 --graph --abbrev-commit` | Compact log (20 entries) |
| `d` | `diff --stat` | Diff summary |
| `amend` | `commit --amend --no-edit` | Amend last commit (keep message) |
| `branches` | `branch -a` | List all branches |
| `tags` | `tag -l` | List all tags |
| `remotes` | `remote -v` | List remotes |
| `recent` | `branch --sort=-committerdate ...` | Branches by last commit date |
| `undo` | `reset --soft HEAD~1` | Undo last commit (keep changes staged) |
| `cleanup` | `branch --merged \| ... \| xargs git branch -d` | Delete merged branches |
| `dag` | `log --graph --format=...` | Detailed DAG with colors |

## User Identity

Not tracked in this repo. After installing, create `~/.config/git/config.local`:

```gitconfig
[user]
    name = Your Name
    email = you@example.com
```

This is included automatically via `[include] path = ~/.config/git/config.local`.
