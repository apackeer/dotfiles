return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jay-babu/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- Formatter/linter installation (Mason handles downloading)
    local machine = (vim.uv or vim.loop).os_uname().machine
    local checkmake_supported = vim.fn.has('mac') == 1
      or vim.fn.has('win32') == 1
      or (vim.fn.has('linux') == 1 and machine == 'x86_64')
    local ensure_installed = {
      'prettier', -- ts/js formatter
      'eslint_d', -- ts/js linter
      'shfmt', -- Shell formatter
      -- 'stylua', -- lua formatter; Already installed via Mason
      -- 'ruff', -- Python linter and formatter; Already installed via Mason
    }
    if checkmake_supported then
      table.insert(ensure_installed, 'checkmake') -- linter for Makefiles
    end

    require('mason-null-ls').setup {
      ensure_installed = ensure_installed,
      automatic_installation = true,
    }

    -- Formatter/linter configuration (what to run and how)
    local sources = {
      formatting.prettier.with { filetypes = { 'html', 'json', 'yaml', 'markdown' } },
      formatting.stylua,
      formatting.shfmt.with { args = { '-i', '4' } },
      formatting.terraform_fmt,
      require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
      require 'none-ls.formatting.ruff_format',
    }
    if checkmake_supported then
      table.insert(sources, diagnostics.checkmake)
    end

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if client:supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false }
            end,
          })
        end
      end,
    }
  end,
}
