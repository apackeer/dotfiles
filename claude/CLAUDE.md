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

## Never use em or en dashes, ever

Only use characters I can type directly on a standard keyboard. That means NO em
dashes (`—`) and NO en dashes (`–`) in ANYTHING you produce for me: chat replies,
plans, commit messages, PR/MR bodies, code comments, docs, HTML, drafted
emails/Slack, vault notes. Every surface, no exceptions. Use a regular hyphen
(`-`), a comma, a period, parentheses, or a colon instead, and rewrite the
sentence if it needs it. This is absolute.

This holds AFTER the humanizer runs too. The humanizer only reduces these dashes;
it does not remove them all. So treat dash elimination as a final pass on the
humanizer's output: scan the result and replace every remaining `—` and `–`
before showing me anything. A humanized draft with an em or en dash still in it
is a failure.

Same principle for other non-keyboard characters: no curly quotes (use `'` and
`"`), no ellipsis character (use three periods). If it is not on a standard
keyboard, do not use it.

## One-liners

- **Plan/design** → use `/grill-me` to stress-test before finalising.
- **After a compaction** → re-read the authoritative plan/design docs before acting; never let a resume-note summary replace the mission.
- **Always Recommend** → every choice I present (AskUserQuestion or chat menu) puts the recommended option FIRST with "(Recommended)" in the label + the reason; toss-ups marked "(Toss-up)". A PreToolUse hook enforces this on AskUserQuestion.
- **Vault search** → run `/vault search` only when the task plausibly relates to vault content (personal projects, life admin, past decisions) or I mention it; never as a reflex before coding.
- **Obsidian Vault** → NEVER touch `~/Documents/Obsidian Vault` with file tools or Bash; the ONLY interface is the `/vault` skill (it owns sync/frontmatter/linking/PARA).
- **Humanize** → run the `humanizer` skill on any text for another human on an external surface (email, Slack, social, long-form); silent pass, show only the result. NOT for terminal replies, vault content, code, commits, PR descriptions, or personal notes.
- **WebSearch down** → fall back to WebFetch against `duckduckgo.com/html/?q=...`, then fetch the results.

## Picking the right models for workflows and subagents

Rankings, higher = better. Cost reflects what I actually pay (gpt-5.6-sol runs via
Amazon Bedrock on my AWS account, so it's cheap-to-me but not free). Intelligence
is how hard a problem you can hand the model unsupervised. Taste covers UI/UX,
code quality, API design, and copy.

| model       | cost | intelligence | taste |
|-------------|------|--------------|-------|
| gpt-5.6-sol | 8    | 8            | 5     |
| sonnet-5    | 5    | 5            | 7     |
| opus-4.8    | 4    | 7            | 8     |
| fable-5     | 2    | 9            | 9     |

How to apply:

- These are defaults, not limits. You have standing permission to override them:
  if a cheaper model's output doesn't meet the bar, rerun or redo the work with a
  smarter model without asking. Judge the output, not the price tag. Escalating
  costs less than shipping mediocre work.
- Cost is a tie-breaker only; when axes conflict for anything that ships,
  intelligence > taste > cost.
- Bulk/mechanical work (clear-spec implementation, data analysis, migrations):
  gpt-5.6-sol via the codex skill.
- Anything user-facing (UI, copy, API design) needs taste >= 7.
- Reviews of plans/implementations: fable-5 or opus-4.8, optionally gpt-5.6-sol as an
  extra independent perspective via the codex-review skill.
- Computer use and runtime UI verification: gpt-5.6-sol via the codex-computer-use
  skill (confirmed working on Bedrock).
- Web research stays with Claude (WebSearch/WebFetch): Codex on Bedrock has NO
  web_search tool; never dispatch research-the-web tasks to it.
- Mechanics: gpt-5.6-sol is only reachable through the Codex CLI (`codex exec` /
  `codex review`; my ~/.codex/config.toml runs amazon-bedrock, model
  openai.gpt-5.6-sol, default effort xhigh). Use the codex, codex-review, and
  codex-computer-use skills; for work they don't cover, run
  `codex exec -s read-only` directly with a self-contained prompt.
- Claude models (sonnet-5, opus-4.8, fable-5) run via the Agent/Workflow model
  parameter.

Using gpt-5.6-sol inside workflows and subagents (the model parameter only takes
Claude models, so use a wrapper):

- Spawn a thin Claude wrapper agent with `model: 'sonnet', effort: 'low'` whose
  prompt instructs it to write a self-contained codex prompt, run `codex exec`
  via Bash per the codex skill, and return the report (use `schema` on the
  wrapper to get structured output back).
- Always label these agents with a `gpt-5.6-sol:` prefix, e.g.
  `{label: 'gpt-5.6-sol:review-auth'}`: the workflow UI shows the wrapper's Claude
  model, so the label is the only indication the real worker is gpt-5.6-sol.
- Codex runs can exceed Bash's 10-minute timeout: pass an explicit timeout, or
  run in the background and poll for the report file.
- Parallel gpt-5.6-sol implementation agents must use `isolation: 'worktree'` so
  codex edits don't collide in the shared checkout.
- My push/PR/merge action gates apply to Codex output exactly as to Claude's:
  Codex may commit inside its own worktree, but nothing leaves the machine
  without my go-ahead.
