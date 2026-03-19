-- Render markdown with rich formatting in-buffer
return {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {},
    config = function(_, opts)
        require('render-markdown').setup(opts)
        vim.keymap.set('n', '<leader>mr', '<cmd>RenderMarkdown toggle<cr>', { desc = 'Toggle render-markdown' })
    end,
}
