return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        { 'mason-org/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
        -- mason-lspconfig:
        -- - Bridges the gap between LSP config names (e.g. "lua_ls") and actual Mason package names (e.g. "lua-language-server").
        -- - Used here only to allow specifying language servers by their LSP name (like "lua_ls") in `ensure_installed`.
        -- - It does not auto-configure servers — we use vim.lsp.config() + vim.lsp.enable() explicitly for full control.
        'mason-org/mason-lspconfig.nvim',
        -- mason-tool-installer:
        -- - Installs LSPs, linters, formatters, etc. by their Mason package name.
        -- - We use it to ensure all desired tools are present.
        -- - The `ensure_installed` list works with mason-lspconfig to resolve LSP names like "lua_ls".
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        -- Useful status updates for LSP.
        {
            'j-hui/fidget.nvim',
            opts = {
                notification = {
                    window = {
                        winblend = 0, -- Background color opacity in the notification window
                    },
                },
            },
        },

        -- Allows extra capabilities provided by nvim-cmp
        'hrsh7th/cmp-nvim-lsp',

        -- Lazily provides Neovim plugin types to lua_ls (much faster than indexing all runtime paths)
        {
            'folke/lazydev.nvim',
            opts = {
                library = {
                    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                },
            },
        },
    },
    config = function()
        -- [[ Semantic Tokens Fix ]]
        -- Wrap semantic_tokens.start to handle race condition with Neo-tree.
        -- When Neo-tree's DiagnosticChanged handler fires during LSP attach, it can
        -- cause the client to temporarily detach before the scheduled semantic_tokens.start()
        -- runs. Instead of warning, retry after 100ms to let things settle.
        do
            local orig = vim.lsp.semantic_tokens.start
            vim.lsp.semantic_tokens.start = function(bufnr, client_id, opts)
                if not vim.lsp.buf_is_attached(bufnr, client_id) then
                    vim.defer_fn(function()
                        if vim.api.nvim_buf_is_valid(bufnr) and vim.lsp.buf_is_attached(bufnr, client_id) then
                            orig(bufnr, client_id, opts)
                        end
                    end, 100)
                    return
                end
                orig(bufnr, client_id, opts)
            end
        end

        -- [[ LSP Attach ]]
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                -- Create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-t>.
                map('gd', require('telescope.builtin').lsp_definitions, 'Go to definition')

                -- Find references for the word under your cursor.
                map('gr', require('telescope.builtin').lsp_references, 'Find references')

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map('gI', require('telescope.builtin').lsp_implementations, 'Go to implementation')

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type definition')

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document symbols')

                -- Fuzzy find all the symbols in your current workspace.
                --  Similar to document symbols, except searches over your entire project.
                map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols')

                -- Rename the variable under your cursor.
                --  Most Language Servers support renaming across files, etc.
                map('<leader>rn', vim.lsp.buf.rename, 'Rename symbol')

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                map('<leader>ca', vim.lsp.buf.code_action, 'Code action', { 'n', 'x' })

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map('gD', vim.lsp.buf.declaration, 'Go to declaration')

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end

                -- The following code creates a keymap to toggle inlay hints in your
                -- code, if the language server you are using supports them
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, 'Toggle inlay hints')
                end
            end,
        })

        -- [[ Capabilities ]]
        -- Capabilities = feature negotiation between Neovim and language servers.
        -- nvim-cmp adds extra capabilities (e.g. snippet support) beyond Neovim's defaults.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        -- [[ Server Configs ]]
        --
        -- Add any additional override configuration in the following tables. Available keys are:
        -- - cmd (table): Override the default command used to start the server
        -- - filetypes (table): Override the default list of associated filetypes for the server
        -- - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        -- - settings (table): Override the default settings passed when initializing the server.
        local servers = {
            ts_ls = {},
            ruff = {},
            pylsp = {
                settings = {
                    pylsp = {
                        plugins = {
                            pyflakes = { enabled = false },
                            pycodestyle = { enabled = false },
                            autopep8 = { enabled = false },
                            yapf = { enabled = false },
                            mccabe = { enabled = false },
                            pylsp_mypy = { enabled = false },
                            pylsp_black = { enabled = false },
                            pylsp_isort = { enabled = false },
                        },
                    },
                },
            },
            html = { filetypes = { 'html', 'twig', 'hbs' } },
            cssls = {},
            tailwindcss = {},
            dockerls = {},
            sqlls = {},
            terraformls = {},
            jsonls = {},
            yamlls = {},
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = 'Replace',
                        },
                        runtime = { version = 'LuaJIT' },
                        diagnostics = {
                            globals = { 'vim' },
                            disable = { 'missing-fields' },
                        },
                        format = {
                            enable = false,
                        },
                    },
                },
            },
        }

        -- [[ Install Loop ]]
        -- Ensure the servers and tools above are installed
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            'stylua', -- Used to format Lua code
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        -- Configure and enable each server, merging base capabilities with any server-specific overrides
        for server, cfg in pairs(servers) do
            cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})

            vim.lsp.config(server, cfg)
            vim.lsp.enable(server)
        end
    end,
}
