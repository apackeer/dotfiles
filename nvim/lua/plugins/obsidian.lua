return {
    'epwalsh/obsidian.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    ft = 'markdown',
    -- Lazy-load triggers for commands not already covered by keys below
    cmd = { 'ObsidianTemplate', 'ObsidianWorkspace', 'ObsidianOpen', 'ObsidianDailies' },
    -- Global keymaps — work from any buffer, also lazy-load the plugin on first press
    keys = {
        { '<leader>ot', '<cmd>ObsidianToday<cr>', desc = 'Obsidian: Today' },
        { '<leader>on', '<cmd>ObsidianNew<cr>', desc = 'Obsidian: New note' },
        { '<leader>os', '<cmd>ObsidianSearch<cr>', desc = 'Obsidian: Search' },
        { '<leader>oq', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Obsidian: Quick switch' },
    },
    opts = {
        -- render-markdown.nvim handles UI rendering
        ui = { enable = false },
        workspaces = {
            {
                name = 'Obsidian Vault',
                path = '~/Documents/Obsidian Vault',
            },
        },
        daily_notes = {
            folder = '1. Daily',
            date_format = '%Y-%m-%d',
            template = 'Daily Note',
            default_tags = {},
        },
        templates = {
            folder = 'Templates',
            date_format = '%Y-%m-%d',
            time_format = '%H:%M',
        },
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
        -- :ObsidianNew routes to Inbox (CLAUDE.md rule 6: "Not sure yet → 0. Inbox/")
        new_notes_location = 'notes_subdir',
        notes_subdir = '0. Inbox',
        attachments = {
            img_folder = '.',
        },
        preferred_link_style = 'wiki',
        -- Skip frontmatter for Archive (already has correct frontmatter)
        disable_frontmatter = function(fname)
            if fname == nil then return false end
            return fname:match('^5%%. Archive/') ~= nil
        end,
        -- Use title as filename; fallback to "Untitled YYYY-MM-DD HHMM" instead of epoch
        note_id_func = function(title)
            if title ~= nil then
                -- Title Case: capitalize first letter of each word
                return title:gsub('(%a)([%w]*)', function(first, rest)
                    return first:upper() .. rest
                end)
            end
            return 'Untitled ' .. os.date('%Y-%m-%d %H%M')
        end,
        -- Build frontmatter on save: preserve existing fields, infer type/area/project from folder path
        note_frontmatter_func = function(note)
            local out = {}

            -- Preserve all existing metadata (type, status, goal, deadline, etc.)
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end

            -- Always include core fields
            out.id = note.id or out.id
            out.aliases = note.aliases or out.aliases or {}
            out.tags = note.tags or out.tags or {}

            -- Infer type, area, project from path (only when not already set)
            if note.path ~= nil then
                local path = tostring(note.path)
                if out.type == nil then
                    if path:match('1%%. Daily/') then
                        out.type = 'daily'
                    elseif path:match('2%%. Projects/') then
                        out.type = 'project'
                    elseif path:match('3%%. Areas/') then
                        out.type = 'area'
                    elseif path:match('4%%. Resources/') then
                        out.type = 'resource'
                    end
                end

                -- Infer area from path: 3. Areas/<Subfolder>/
                if (out.area == nil or out.area == '') then
                    local area = path:match('3%%. Areas/([^/]+)/')
                    out.area = area or ''
                end

                -- Infer project from path: 2. Projects/<Subfolder>/
                if (out.project == nil or out.project == '') then
                    local project = path:match('2%%. Projects/([^/]+)/')
                    out.project = project or ''
                end
            end

            -- Ensure area/project exist even if path inference didn't set them
            if out.area == nil then out.area = '' end
            if out.project == nil then out.project = '' end

            return out
        end,
        -- Buffer-local keymaps — only active inside markdown files in the vault
        mappings = {
            -- Follow [[wikilink]] under cursor
            ['<leader>of'] = {
                action = function()
                    return require('obsidian').util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            -- Toggle checkbox with auto done-stamp
            ['<leader>od'] = {
                action = function()
                    require('obsidian').util.toggle_checkbox()
                    local line_num = vim.api.nvim_win_get_cursor(0)[1]
                    local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
                    if line:match('%- %[x%]') then
                        -- Checked: add [done:: date] if not present
                        if not line:match('%[done::') then
                            local today = os.date('%Y-%m-%d')
                            line = line .. ' [done:: ' .. today .. ']'
                        end
                    else
                        -- Unchecked: remove [done:: ...] if present
                        line = line:gsub('%s*%[done::%s*[%d%-]+%]', '')
                    end
                    vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { line })
                end,
                opts = { buffer = true, desc = 'Obsidian: Toggle checkbox + done stamp' },
            },
            -- Add a new task line
            ['<leader>oa'] = {
                action = function()
                    vim.ui.input({ prompt = 'Task (append " due YYYY-MM-DD" for due date): ' }, function(input)
                        if not input or input == '' then return end
                        local task_text = input
                        local due = input:match('%s+due%s+(%d%d%d%d%-%d%d%-%d%d)%s*$')
                        if due then
                            task_text = input:gsub('%s+due%s+%d%d%d%d%-%d%d%-%d%d%s*$', '')
                            task_text = '- [ ] ' .. task_text .. ' [due:: ' .. due .. ']'
                        else
                            task_text = '- [ ] ' .. input
                        end
                        local row = vim.api.nvim_win_get_cursor(0)[1]
                        vim.api.nvim_buf_set_lines(0, row, row, false, { task_text })
                        vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
                    end)
                end,
                opts = { buffer = true, desc = 'Obsidian: Add task' },
            },
            -- Insert template
            ['<leader>op'] = {
                action = '<cmd>ObsidianTemplate<cr>',
                opts = { buffer = true, desc = 'Obsidian: Insert template' },
            },
            -- Rename current note (updates all backlinks)
            ['<leader>or'] = {
                action = '<cmd>ObsidianRename<cr>',
                opts = { buffer = true, desc = 'Obsidian: Rename note' },
            },
            -- Extract visual selection to new note
            ['<leader>oe'] = {
                action = '<cmd>ObsidianExtractNote<cr>',
                opts = { buffer = true, desc = 'Obsidian: Extract to note' },
            },
        },
    },
}
