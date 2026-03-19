return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  config = function()
    require('nvim-treesitter').setup()
    -- Ensure parsers are installed
    local ensure_installed = {
      'lua', 'python', 'javascript', 'typescript', 'vimdoc', 'vim',
      'regex', 'terraform', 'sql', 'dockerfile', 'toml', 'json',
      'java', 'groovy', 'go', 'gitignore', 'graphql', 'yaml',
      'make', 'cmake', 'markdown', 'markdown_inline', 'bash',
      'tsx', 'css', 'html',
    }
    -- Install any missing parsers (avoids manual :TSInstall on first launch)
    local installed = require('nvim-treesitter').get_installed()
    for _, lang in ipairs(ensure_installed) do
      if not vim.tbl_contains(installed, lang) then
        require('nvim-treesitter').install({ lang })
      end
    end
  end,
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
