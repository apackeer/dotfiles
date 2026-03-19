-- Autocommands

-- Auto-reload files changed outside of Neovim (e.g. by Claude Code)
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  command = 'checktime',
})
