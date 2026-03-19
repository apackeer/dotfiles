-- Color scheme (Solarized Dark)
return {
    'ishan9299/nvim-solarized-lua',
    lazy = false,
    priority = 1000,
    config = function()
        vim.o.background = 'dark'
        vim.cmd.colorscheme 'solarized'
    end,
}
