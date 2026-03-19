require 'core.options' -- Editor settings (tabs, numbers, clipboard, etc.)
require 'core.keymaps' -- Key mappings and diagnostic config
require 'core.autocommands' -- Autocommands (auto-reload, etc.)

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Plugin Specifications ]]
require('lazy').setup {
    -- UI
    require 'plugins.colortheme',
    require 'plugins.bufferline',
    require 'plugins.lualine',
    require 'plugins.neo-tree',

    -- Editor
    require 'plugins.treesitter',
    require 'plugins.telescope',

    -- LSP & Completion
    require 'plugins.lsp',
    require 'plugins.autocompletion',
    require 'plugins.autoformatting',

    -- Git
    require 'plugins.gitsigns',

    -- Misc
    require 'plugins.alpha',
    require 'plugins.indent-blankline',
    require 'plugins.misc',
    require 'plugins.comment',
    require 'plugins.render-markdown',
    require 'plugins.obsidian',
}
