# Claude Code config

Symlinked into `~/.claude/` by `symlinks.conf`:

- `CLAUDE.md` — global instructions
- `statusline.sh` — status line script
- `hooks/check-read-size.sh` — blocks Read on files >2000 lines, suggests chunks
- `hooks/check-askuser-recommend.sh` — enforces "(Recommended)" on AskUserQuestion options

## settings.json — copy, don't symlink

`settings.json` here is a **sanitized template** (this repo is public). On a new
machine, copy it instead of symlinking:

```sh
cp claude/settings.json ~/.claude/settings.json
```

Then re-add the machine/account-specific bits that are deliberately stripped:

- `awsAuthRefresh` — the `ada credentials update ...` command with the AWS
  account ID (lives only in the local file, never committed)

After editing the local copy, sync non-sensitive changes back here manually.
`settings.local.json` is not an option for this: Claude Code only loads
`settings.local.json` at project scope, so user-level overrides must live in
`~/.claude/settings.json` itself.
