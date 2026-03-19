-- Keymaps for better default experience

-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymap helper
local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Navigation

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
map('n', '<Esc>', ':noh<CR>', 'Clear search highlights')

-- save file
map('n', '<C-s>', '<cmd> w <CR>', 'Save file')

-- save file without auto-formatting
map('n', '<leader>W', '<cmd>noautocmd w <CR>', 'Save without formatting')

-- quit file
map('n', '<C-q>', '<cmd> q <CR>', 'Quit')

-- delete single character without copying into register
map('n', 'x', '"_x', 'Delete char (no yank)')

-- Scroll / Center

map('n', '<C-d>', '<C-d>zz', 'Scroll down + center')
map('n', '<C-u>', '<C-u>zz', 'Scroll up + center')

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Resize with arrows
-- map('n', '<Up>', ':resize -2<CR>', 'Resize height -2')
-- map('n', '<Down>', ':resize +2<CR>', 'Resize height +2')
-- map('n', '<Left>', ':vertical resize -2<CR>', 'Resize width -2')
-- map('n', '<Right>', ':vertical resize +2<CR>', 'Resize width +2')

-- Buffers

map('n', '<Tab>', ':bnext<CR>', 'Next buffer')
map('n', '<S-Tab>', ':bprevious<CR>', 'Previous buffer')
vim.keymap.set('n', '<C-i>', '<C-i>', { noremap = true, silent = true }) -- restore jump forward
map('n', '<leader>x', ':Bdelete!<CR>', 'Close buffer')
map('n', '<leader>b', '<cmd> enew <CR>', 'New buffer')

-- Windows

map('n', '<leader>\\', '<C-w>v', 'Split vertically')
map('n', '<leader>-', '<C-w>s', 'Split horizontally')
map('n', '<leader>=', '<C-w>=', 'Equalize splits')

-- Navigate between splits
map('n', '<C-k>', ':wincmd k<CR>', 'Navigate up')
map('n', '<C-j>', ':wincmd j<CR>', 'Navigate down')
map('n', '<C-h>', ':wincmd h<CR>', 'Navigate left')
map('n', '<C-l>', ':wincmd l<CR>', 'Navigate right')

-- Toggle line wrapping
map('n', '<leader>wr', '<cmd>set wrap!<CR>', 'Toggle line wrap')

-- Quick escape from insert mode (press jk or kj rapidly)
map('i', 'jk', '<ESC>', 'Exit insert mode')
map('i', 'kj', '<ESC>', 'Exit insert mode')

-- Visual Mode

-- Stay in indent mode
map('v', '<', '<gv', 'Indent left')
map('v', '>', '>gv', 'Indent right')

-- Move text up and down
map('v', '<A-j>', ':m .+1<CR>==', 'Move selection down')
map('v', '<A-k>', ':m .-2<CR>==', 'Move selection up')

-- Keep last yanked when pasting
map('v', 'p', '"_dP', 'Paste (keep register)')

-- Replace word under cursor
map('n', '<leader>j', '*``cgn', 'Replace word under cursor')

-- Clipboard

-- Explicitly yank to system clipboard (highlighted and entire row)
map({ 'n', 'v' }, '<leader>y', [["+y]], 'Yank to clipboard')
map('n', '<leader>Y', [["+Y]], 'Yank line to clipboard')

-- Diagnostics

vim.diagnostic.config {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
    },
    float = {
        border = 'rounded',
    },
    severity_sort = true,
}

-- Toggle diagnostics
local diagnostics_active = true

vim.keymap.set('n', '<leader>dt', function()
    diagnostics_active = not diagnostics_active

    if diagnostics_active then
        vim.diagnostic.enable(true)
    else
        vim.diagnostic.enable(false)
    end
end, { desc = 'Toggle diagnostics' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Sessions

vim.keymap.set('n', '<leader>SS', ':mksession! .session.vim<CR>', { noremap = true, silent = false, desc = 'Save session' })
vim.keymap.set('n', '<leader>SL', ':source .session.vim<CR>', { noremap = true, silent = false, desc = 'Load session' })
