-- Standalone plugins with less than 10 lines of config go here
return {
    {
        -- Tmux & split window navigation
        'christoomey/vim-tmux-navigator',
    },
    {
        -- Detect tabstop and shiftwidth automatically
        'tpope/vim-sleuth',
    },
    {
        -- Powerful Git integration for Vim
        'tpope/vim-fugitive',
    },
    {
        -- GitHub integration for vim-fugitive
        'tpope/vim-rhubarb',
    },
    {
        -- Hints keybinds
        'folke/which-key.nvim',
        event = 'VimEnter',
        opts = {
            spec = {
                { '<leader>s', group = 'Search' },
                { '<leader>d', group = 'Diagnostics' },
                { '<leader>S', group = 'Session' },
                { '<leader>c', group = 'Code' },
                { '<leader>r', group = 'Rename' },
                { '<leader>w', group = 'Workspace' },
                { '<leader>t', group = 'Toggle' },
                { '<leader>l', group = 'Display' },
                { '<leader>n', group = 'Neo-tree' },
                { '<leader>m', group = 'Markdown' },
            },
        },
    },
    {
        -- Autoclose parentheses, brackets, quotes, etc.
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
        opts = {},
    },
    {
        -- Highlight todo, notes, etc in comments
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },
    {
        -- High-performance color highlighter
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
    },
}
