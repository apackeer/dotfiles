# Vim Motions Cheatsheet

A progressive guide — start with Level 1 and build muscle memory before moving on.

---

## Level 1: Survive

Get around without reaching for the mouse.

| Key | Action |
|-----|--------|
| `h/j/k/l` | Left / down / up / right |
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `A` | Insert at end of line |
| `o/O` | New line below / above |
| `Esc` | Back to normal mode |
| `u` | Undo |
| `Ctrl+r` | Redo |
| `.` | Repeat last change |

---

## Level 2: Move with Intent

Stop pressing `j` twenty times.

### Words

| Key | Action |
|-----|--------|
| `w` | Next word start |
| `b` | Previous word start |
| `e` | End of word |
| `W/B/E` | Same but by WORD (whitespace-delimited) |

### Lines

| Key | Action |
|-----|--------|
| `0` | Start of line |
| `$` | End of line |
| `^` | First non-blank character |
| `f{char}` | Jump **to** char on line |
| `t{char}` | Jump **before** char on line |
| `F{char}` / `T{char}` | Same but backwards |
| `;` / `,` | Repeat last f/t forward / backward |

### File

| Key | Action |
|-----|--------|
| `gg` | Top of file |
| `G` | Bottom of file |
| `{number}G` | Go to line number |
| `Ctrl+d` / `Ctrl+u` | Half page down / up |
| `{` / `}` | Previous / next paragraph |
| `%` | Matching bracket |

### Search

| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` / `N` | Next / previous match |
| `*` / `#` | Search word under cursor forward / backward |

---

## Level 3: Operator + Motion (the multiplier)

This is where vim gets powerful. **Operator + motion** = action on text.

### Operators

| Key | Action |
|-----|--------|
| `d` | Delete |
| `c` | Change (delete + insert mode) |
| `y` | Yank (copy) |
| `>` / `<` | Indent / dedent |
| `=` | Auto-indent |

### Combine Them

| Command | What it does |
|---------|-------------|
| `dw` | Delete to next word |
| `d$` or `D` | Delete to end of line |
| `d0` | Delete to start of line |
| `dt)` | Delete until `)` |
| `df"` | Delete through `"` |
| `cw` | Change word |
| `c$` or `C` | Change to end of line |
| `ct,` | Change until `,` |
| `yy` | Yank whole line |
| `yw` | Yank word |
| `dd` | Delete whole line |
| `cc` | Change whole line |
| `>>` | Indent line |

### Counts

Prefix any motion or operator with a number:

| Command | What it does |
|---------|-------------|
| `3w` | Move 3 words forward |
| `5j` | Move 5 lines down |
| `d3w` | Delete 3 words |
| `2dd` | Delete 2 lines |

---

## Level 4: Text Objects (precision editing)

Text objects select meaningful chunks. Use with operators: `{operator}{a/i}{object}`

- `i` = **inner** (contents only)
- `a` = **around** (contents + delimiters/whitespace)

| Object | Inner (`i`) | Around (`a`) |
|--------|-------------|--------------|
| `w` | Word | Word + surrounding space |
| `"` | Inside quotes | Quotes + contents |
| `'` | Inside single quotes | Single quotes + contents |
| `` ` `` | Inside backticks | Backticks + contents |
| `(` or `)` | Inside parens | Parens + contents |
| `{` or `}` | Inside braces | Braces + contents |
| `[` or `]` | Inside brackets | Brackets + contents |
| `t` | Inside HTML tag | Tag + contents |
| `p` | Paragraph | Paragraph + blank lines |
| `s` | Sentence | Sentence + space |

### Examples That Stick

| Command | What it does | When you'd use it |
|---------|-------------|-------------------|
| `ci"` | Change inside `"..."` | Rewrite a string |
| `da(` | Delete around `(...)` | Remove a function call's args + parens |
| `yiw` | Yank inner word | Copy a variable name |
| `ci{` | Change inside `{...}` | Rewrite a code block |
| `dap` | Delete around paragraph | Remove a whole block |
| `dit` | Delete inside tag | Clear an HTML element's content |
| `va"` | Visual select around `"..."` | See what you're about to act on |

---

## Level 5: Marks, Registers & Macros

### Marks

| Key | Action |
|-----|--------|
| `m{a-z}` | Set mark (buffer-local) |
| `'{a-z}` | Jump to mark (line) |
| `` `{a-z} `` | Jump to mark (exact position) |
| `''` | Jump back to last position |

### Registers

| Key | Action |
|-----|--------|
| `"{reg}y{motion}` | Yank into register |
| `"{reg}p` | Paste from register |
| `"ay3j` | Yank 3 lines into register `a` |
| `"ap` | Paste register `a` |
| `"0p` | Paste last yank (not delete) |
| `:reg` | Show all registers |

### Macros

| Key | Action |
|-----|--------|
| `q{a-z}` | Start recording macro |
| `q` | Stop recording |
| `@{a-z}` | Play macro |
| `@@` | Replay last macro |
| `5@a` | Play macro `a` five times |

---

## Practice Drills

Build muscle memory with these daily exercises:

1. **Navigation**: Open a file, move around using only `w`, `b`, `e`, `f`, `{`, `}`. No arrow keys.
2. **Operator + motion**: Edit code using `ciw`, `dw`, `ct,`, `da(`. Avoid `x` and backspace.
3. **Text objects**: In any code file, practice `ci"`, `ci(`, `ci{`, `dap` on real code.
4. **Dot repeat**: Make a change with `ciw`, then move to similar words and press `.`
5. **Search + action**: Use `*` to find a word, then `cgn` to change it, then `.` to repeat on each occurrence.

### The Golden Rule

If you're pressing the same key more than 3 times, there's a better motion.

| Instead of... | Try... |
|---------------|--------|
| `jjjjj` | `5j` or `}` or `/target` |
| `xxxxx` | `dw` or `dt{char}` |
| `lllll` | `w` or `f{char}` |
| Select + delete | `diw`, `dap`, `di"` |
| Arrow keys | `h/j/k/l` (then graduate to motions) |
