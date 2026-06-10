## Always Recommend — every choice you present

When presenting options (AskUserQuestion or a menu in chat), put your
recommended option FIRST with "(Recommended)" in its label, and give the
reason in its description. Prose above the menu does not count — the marker
must be in the label string itself. If it's genuinely a toss-up (rare),
mark the first option "(Toss-up)" and explain why neither wins.
A PreToolUse hook (`hooks/check-askuser-recommend.sh`) enforces this on
AskUserQuestion calls; chat menus follow the same rule.

## After Any Compaction — reload the mission

On long-running efforts, re-read the authoritative plan/design docs after
a context compaction BEFORE acting. Never let a resume note's summary
replace the vision.

## Vault Search — only when relevant

Search the vault (`/vault search <topic>`) only when the task plausibly
relates to vault content: personal projects, life admin, past decisions,
or when I explicitly mention the vault or a topic I journal about. Do NOT
run it as a reflex before coding tasks — repos carry their own context
(CLAUDE.md, project memory, docs). When in doubt on a coding task, skip
it; I'll ask if I want vault context pulled in.

## Read and Verify Before Acting

Before writing any file path, line number, function name, test ID,
constant, or convention — in plans, commits, edits, or chat — read the
source and show the grep/read that confirmed it in the same turn. This
applies to side-fixes and "while I'm here" changes too. Plans are targets,
not records; the code is the record. If pattern-matching from memory feels
faster than grepping, that's the moment to grep.

## Obsidian Vault — never touch directly

Never access any path under `~/Documents/Obsidian Vault` with Read, Write,
Edit, Grep, Glob, or Bash — for any reason. The ONLY interface is the
`/vault` skill: `Skill(skill: "vault", args: "search <query>")` (likewise
create or any other operation). Inside the skill's own execution, file
tools are fine — that is how it works internally. The skill owns sync,
frontmatter, auto-linking, auto-tagging, and PARA routing; direct access
breaks all of them.

## Planning

When asked to create a plan or design, use `/grill-me` to stress-test the
approach before finalising.

## Public-Facing Text — always humanize

Run the `humanizer` skill (`Skill(skill: "humanizer", args: "<text>")`)
on any text destined for another human on an external surface — emails,
Slack, LinkedIn/blog/social/long-form publishing. Every draft I'm shown,
including rough first passes and post-tweak revisions, whether you
composed it or edited mine. Silent pass: present only the humanized
version, no diff, no report.

Do NOT humanize: conversational replies in this terminal; vault content
(journal entries, notes, any `/vault` writes — that is your voice, for
you, never clean it up); code, commit messages, PR descriptions, internal
docs; anything personal or for-my-own-use only.
