-- Render markdown with rich formatting in-buffer
return {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        checkbox = {
            unchecked = { icon = '󰄱 ' },
            checked = { icon = '󰄵 ' },
        },
    },
    config = function(_, opts)
        require('render-markdown').setup(opts)
        vim.api.nvim_set_hl(0, 'RenderMarkdownChecked', { fg = '#859900', bold = true })
        vim.api.nvim_set_hl(0, 'RenderMarkdownUnchecked', { fg = '#d33682', bold = true })
        vim.keymap.set('n', '<leader>mr', '<cmd>RenderMarkdown toggle<cr>', { desc = 'Toggle render-markdown' })
    end,
}
