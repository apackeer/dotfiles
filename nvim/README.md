# Neovim

Quick reference for all keybindings, plugins, and settings in this config.

**Leader key: `Space`**

---

## Key Philosophy

| Modifier | When to use | Examples |
|----------|-------------|---------|
| **Ctrl** | Reflexive, in-flow. Don't break stride. | Save, quit, scroll, navigate splits, comment, completion |
| **Leader** | Intentional, deliberate. Pause and decide. | Search, code intelligence, file management, sessions |
| **Vim conventions** | Built-in motion language. No modifier. | `g*` go-to, `[`/`]` prev/next, motions |

---

## Search (`<leader>s*`)

| Key | Action |
|-----|--------|
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep |
| `<leader>sw` | Grep current word |
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>ss` | Telescope builtins |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Resume last search |
| `<leader>s.` | Recent files |
| `<leader>s/` | Grep open files |
| `<leader>/` | Fuzzy find in current buffer |
| `<leader><leader>` | Find open buffers |

### Inside Telescope Picker

| Key | Action |
|-----|--------|
| `<C-j>` | Next result |
| `<C-k>` | Previous result |
| `<C-l>` | Open selected |
| `<C-/>` (Insert) / `?` (Normal) | Show picker keymaps |

---

## Diagnostics (`<leader>d*`)

| Key | Action |
|-----|--------|
| `<leader>dd` | Open floating diagnostic |
| `<leader>dt` | Toggle diagnostics on/off |
| `<leader>ds` | Document symbols |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>q` | Diagnostics loclist |

---

## LSP

### Go-to (`g` prefix)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `<C-t>` | Jump back |

### Actions (standalone mnemonic)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ca` | Normal/Visual | Code action |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>D` | Normal | Type definition |
| `<leader>ws` | Normal | Workspace symbols |
| `<leader>th` | Normal | Toggle inlay hints |

### LSP Behaviors

- **Auto-highlight:** References under cursor are highlighted on `CursorHold`
- **Auto-format on save:** Enabled via none-ls (`BufWritePre`)

---

## Completion (insert mode)

| Key | Action |
|-----|--------|
| `<C-n>` / `<Tab>` | Next completion item |
| `<C-p>` / `<S-Tab>` | Previous completion item |
| `<C-y>` | Accept completion |
| `<C-Space>` | Trigger completion manually |
| `<C-b>` / `<C-f>` | Scroll docs up / down |
| `<C-l>` / `<C-h>` | Next / prev snippet placeholder |

Completion sources (priority order): lazydev, LSP, snippets, buffer, path.

---

## Window & Splits

| Key | Action |
|-----|--------|
| `<leader>\` | Split vertically |
| `<leader>-` | Split horizontally |
| `<leader>=` | Equalize splits |
| `<C-w>c` | Close split (native vim) |
| `<C-h/j/k/l>` | Navigate between splits |
| `<Up/Down>` | Resize height (+/-2) |
| `<Left/Right>` | Resize width (+/-2) |

---

## Buffers

| Key | Action |
|-----|--------|
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>x` | Close buffer |
| `<leader>b` | New empty buffer |

---

## File Explorer (Neo-tree)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `\` | Reveal current file in tree |
| `<leader>ngs` | Git status (float) |

### Inside Neo-tree

| Key | Action |
|-----|--------|
| `<CR>` / `l` | Open file |
| `<Space>` | Toggle node expand/collapse |
| `s` | Open in vertical split |
| `S` | Open in horizontal split |
| `t` | Open in new tab |
| `w` | Open with window picker |
| `P` | Toggle float preview |
| `a` | Add file |
| `A` | Add directory |
| `d` | Delete |
| `r` | Rename |
| `c` | Copy (prompts for destination) |
| `m` | Move (prompts for destination) |
| `y` | Copy to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |
| `C` | Close node |
| `z` | Close all nodes |
| `H` | Toggle hidden files |
| `/` | Fuzzy finder |
| `D` | Fuzzy finder (directories) |
| `f` | Filter on submit |
| `<C-x>` | Clear filter |
| `<BS>` | Navigate up |
| `.` | Set root |
| `[g` / `]g` | Prev/next git modified |
| `o` | Order by... (submenu) |
| `R` | Refresh |
| `q` | Close window |
| `?` | Show help |
| `i` | Show file details |

### Neo-tree Git Status Window

| Key | Action |
|-----|--------|
| `A` | Git add all |
| `ga` | Git add file |
| `gu` | Git unstage file |
| `gr` | Git revert file |
| `gc` | Git commit |
| `gp` | Git push |
| `gg` | Git commit and push |

---

## Session (`<leader>S*`)

| Key | Action |
|-----|--------|
| `<leader>SS` | Save session |
| `<leader>SL` | Load session |

---

## Saving & Quitting

| Key | Action |
|-----|--------|
| `<C-s>` | Save file |
| `<leader>W` | Save without auto-formatting |
| `<C-q>` | Quit |

---

## Comment

| Key | Mode | Action |
|-----|------|--------|
| `<C-/>` | Normal | Toggle comment on current line |
| `<C-/>` | Visual | Toggle comment on selection |

---

## Editing

| Key | Mode | Action |
|-----|------|--------|
| `<leader>j` | Normal | Replace word under cursor |
| `<C-a>` / `<C-x>` | Normal | Increment / decrement number (native vim) |
| `x` | Normal | Delete char without yanking |

---

## Clipboard

| Key | Mode | Action |
|-----|------|--------|
| `<leader>y` | Normal/Visual | Yank to system clipboard |
| `<leader>Y` | Normal | Yank line to system clipboard |
| `p` | Visual | Paste without overwriting register |

---

## Display

| Key | Action |
|-----|--------|
| `<leader>wr` | Toggle line wrap |
| `<leader>mr` | Toggle markdown rendering |

---

## Navigation & Scrolling

| Key | Action |
|-----|--------|
| `j` / `k` | Move through wrapped lines |
| `<C-d>` / `<C-u>` | Scroll down/up + center |
| `n` / `N` | Next/prev search + center |
| `<Esc>` | Clear search highlights |

---

## Insert Mode

| Key | Action |
|-----|--------|
| `jk` / `kj` | Exit insert mode |

## Visual Mode

| Key | Action |
|-----|--------|
| `<` / `>` | Indent and stay in visual |
| `<A-j>` / `<A-k>` | Move selection down/up |

---

## Installed Plugins

### Core / UI

| Plugin | Description |
|--------|-------------|
| **lazy.nvim** | Plugin manager |
| **nvim-solarized-lua** | Solarized dark colorscheme |
| **bufferline.nvim** | Buffer tab bar (with vim-bbye for close) |
| **lualine.nvim** | Status line (solarized dark theme) |
| **alpha-nvim** | Dashboard / start screen |
| **indent-blankline.nvim** | Indent guide lines |
| **nvim-web-devicons** | File type icons |
| **which-key.nvim** | Keybinding hints popup |
| **nvim-colorizer.lua** | Inline color highlighting |

### Navigation & Search

| Plugin | Description |
|--------|-------------|
| **telescope.nvim** | Fuzzy finder (files, grep, buffers, etc.) |
| **telescope-fzf-native.nvim** | FZF sorter for Telescope |
| **telescope-ui-select.nvim** | Use Telescope for `vim.ui.select` |
| **neo-tree.nvim** | File explorer sidebar |
| **nvim-window-picker** | Window picker for Neo-tree splits |
| **vim-tmux-navigator** | Seamless tmux/vim split navigation |

### LSP & Completion

| Plugin | Description |
|--------|-------------|
| **nvim-lspconfig** | LSP configuration |
| **mason.nvim** | LSP/tool installer |
| **mason-lspconfig.nvim** | Bridge Mason and lspconfig names |
| **mason-tool-installer.nvim** | Auto-install tools via Mason |
| **fidget.nvim** | LSP progress notifications |
| **lazydev.nvim** | Neovim Lua API types for lua_ls |
| **nvim-cmp** | Autocompletion engine |
| **cmp-nvim-lsp** | LSP completion source |
| **cmp-buffer** | Buffer completion source |
| **cmp-path** | Path completion source |
| **cmp_luasnip** | Snippet completion source |
| **LuaSnip** | Snippet engine |
| **friendly-snippets** | Pre-made snippet collection |

### Formatting & Linting

| Plugin | Description |
|--------|-------------|
| **none-ls.nvim** | Formatters/linters via LSP interface |
| **none-ls-extras.nvim** | Extra none-ls sources (ruff, etc.) |
| **mason-null-ls.nvim** | Auto-install formatters/linters |

### Git

| Plugin | Description |
|--------|-------------|
| **gitsigns.nvim** | Git signs in gutter (+, ~, _) |
| **vim-fugitive** | Git commands in Vim |
| **vim-rhubarb** | GitHub integration for fugitive |

### Editing

| Plugin | Description |
|--------|-------------|
| **Comment.nvim** | Toggle comments (Ctrl+/) |
| **nvim-autopairs** | Auto-close brackets, quotes, etc. |
| **nvim-treesitter** | Syntax highlighting and code parsing |
| **vim-sleuth** | Auto-detect indent settings |
| **todo-comments.nvim** | Highlight TODO/FIXME/NOTE in comments |
| **render-markdown.nvim** | Rich markdown rendering in buffer |

### Notes

| Plugin | Description |
|--------|-------------|
| **obsidian.nvim** | Obsidian vault integration (daily notes, search, templates, tasks) |

---

## Obsidian (`<leader>o*`)

### Global (any buffer)

| Key | Action |
|-----|--------|
| `<leader>ot` | Today's daily note |
| `<leader>on` | New note |
| `<leader>os` | Search notes |
| `<leader>oq` | Quick switch |

### Buffer-local (markdown files in vault)

| Key | Action |
|-----|--------|
| `<leader>of` | Follow wikilink under cursor |
| `<leader>od` | Toggle checkbox + done stamp |
| `<leader>oa` | Add task |
| `<leader>op` | Insert template |
| `<leader>or` | Rename note (updates backlinks) |
| `<leader>oe` | Extract selection to new note |

---

## LSP Servers

Managed via Mason. All auto-installed on first launch.

| Server | Language |
|--------|----------|
| `lua_ls` | Lua |
| `ts_ls` | TypeScript / JavaScript |
| `pylsp` | Python (completions, no linting - deferred to ruff) |
| `ruff` | Python (linting & formatting) |
| `html` | HTML (+ twig, hbs) |
| `cssls` | CSS |
| `tailwindcss` | Tailwind CSS |
| `jsonls` | JSON |
| `yamlls` | YAML |
| `dockerls` | Dockerfile |
| `sqlls` | SQL |
| `terraformls` | Terraform |

## Formatters & Linters

Installed via mason-null-ls, run through none-ls.

| Tool | Purpose |
|------|---------|
| `stylua` | Lua formatting |
| `prettier` | HTML, JSON, YAML, Markdown formatting |
| `eslint_d` | TypeScript/JavaScript linting |
| `ruff` | Python formatting (with isort) |
| `ruff_format` | Python formatting |
| `shfmt` | Shell formatting (4-space indent) |
| `checkmake` | Makefile linting |
| `terraform_fmt` | Terraform formatting |

---

## Editor Settings

| Setting | Value |
|---------|-------|
| Line numbers | Relative + absolute |
| Tabs | 4 spaces (expandtab) |
| Search | Case-insensitive (smart case) |
| Mouse | Enabled (`a`) |
| Clipboard | Synced with OS (`unnamedplus`) |
| New splits | Below and to the right |
| Undo | Persistent (undofile) |
| Swap/backup files | Disabled |
| Scroll offset | 4 lines vertical, 8 columns horizontal |
| Word wrap | Off by default |
| Sign column | Always visible |
| Colorscheme | Solarized Dark |
| Disabled providers | Perl, Ruby, Python3 |

---

## Notable Behaviors

- **Auto-format on save**: Files are formatted via none-ls on every save. Use `<leader>W` to save without formatting.
- **Neo-tree file watcher**: Uses OS-level file watching (`use_libuv_file_watcher = true`) to detect external changes.
- **Diagnostic signs**: Custom icons for errors, warnings, info, and hints in the sign column.
- **Semantic tokens retry**: A wrapper retries `semantic_tokens.start` if the client temporarily detaches (Neo-tree race condition workaround).
- **Treesitter parsers**: Auto-installed for ~25 languages on first launch.
- **Hidden files in Telescope**: `find_files` and `live_grep` search hidden files but ignore `node_modules`, `.git`, and `.venv`.
- **Neo-tree hidden items**: Dotfiles shown, but `.DS_Store`, `node_modules`, `__pycache__`, `.git`, `.venv`, `.python-version` are hidden by name.
