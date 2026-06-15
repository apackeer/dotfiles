# Global preferences — every session, every domain

## Action gates — STOP and ask, per action

These need MY explicit go-ahead **each time**. An approval is spent the moment
it's used: it never carries to a later or different action, and "do X" earlier in
the session doesn't authorize X again now. Prepare everything (commit, branch,
PR/MR body, merge), then stop and show me. Exception: a goal/prompt doc that
explicitly pre-authorizes an action for that effort counts as written go-ahead.

- **Push** — any `git push` to any remote, GitHub AND GitLab, feature branch as
  much as main. Committing locally is fine; pushing is gated. (This rule exists
  because a push once went out on a stale "commit and push" approval.)
- **GitHub PR** — `gh pr create` or equivalent. GitHub is public; that's why.
  Does NOT apply to GitLab: raise MRs there as normal flow (the push before them
  still needs consent).
- **Merge to main/default** — either platform: `gh pr merge`, GitLab merge API,
  accepting an MR, or a local `git merge` into main + push.

## Stay in the named scope — no sweeps

Do exactly what I asked, nothing adjacent. When I'm working through a list, fold
in ONLY the item I named — no batching, no "while I'm here" cleanups, doc sweeps,
stale-ref fixes, or proactive baselining. Flag side-quests in chat and wait.

## Read and verify before acting

Before writing any file path, line, function, test ID, constant, or convention —
in plans, commits, edits, or chat — read the source and show the grep/read that
confirmed it, same turn. Applies to side-fixes too. The code is the record, not
memory or plausible convention. If grepping feels slower than recalling, grep.

## Snapshot before editing a source-of-truth file

Before editing something I'd want to revert cleanly (tracked file, plan doc,
config), make sure a clean backup exists first — commit the baseline if it's
git-tracked, else copy to a `.bak`. Gives me a clean revert path.

## One-liners

- **Plan/design** → use `/grill-me` to stress-test before finalising.
- **After a compaction** → re-read the authoritative plan/design docs before acting; never let a resume-note summary replace the mission.
- **Always Recommend** → every choice I present (AskUserQuestion or chat menu) puts the recommended option FIRST with "(Recommended)" in the label + the reason; toss-ups marked "(Toss-up)". A PreToolUse hook enforces this on AskUserQuestion.
- **Vault search** → run `/vault search` only when the task plausibly relates to vault content (personal projects, life admin, past decisions) or I mention it; never as a reflex before coding.
- **Obsidian Vault** → NEVER touch `~/Documents/Obsidian Vault` with file tools or Bash; the ONLY interface is the `/vault` skill (it owns sync/frontmatter/linking/PARA).
- **Humanize** → run the `humanizer` skill on any text for another human on an external surface (email, Slack, social, long-form); silent pass, show only the result. NOT for terminal replies, vault content, code, commits, PR descriptions, or personal notes.
- **WebSearch down** → fall back to WebFetch against `duckduckgo.com/html/?q=...`, then fetch the results.
