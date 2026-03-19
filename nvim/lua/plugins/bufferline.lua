return {
    'akinsho/bufferline.nvim',
    dependencies = {
        'moll/vim-bbye',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('bufferline').setup {
            -- Display options
            options = {
                mode = 'buffers', -- set to "tabs" to only show tabpages instead
                themable = true,
                numbers = 'none', -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
                close_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
                buffer_close_icon = '✗',
                close_icon = '✗',
                path_components = 1, -- Show only the file name without the directory
                modified_icon = '●',
                left_trunc_marker = '',
                right_trunc_marker = '',
                max_name_length = 30,
                max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
                tab_size = 21,
                diagnostics = false,
                diagnostics_update_in_insert = false,
                get_element_icon = function(element)
                    local icon = require('nvim-web-devicons').get_icon(vim.fn.fnamemodify(element.path, ':t'), nil, { default = true })
                    if icon then
                        return icon
                    end
                end,
                show_buffer_icons = true,
                show_buffer_close_icons = true,
                show_close_icon = true,
                persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                separator_style = { '│', '│' }, -- | "thick" | "thin" | { 'any', 'any' },
                enforce_regular_tabs = true,
                always_show_bufferline = true,
                show_tab_indicators = false,
                indicator = {
                    -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
                    style = 'none', -- Options: 'icon', 'underline', 'none'
                },
                icon_pinned = '󰐃',
                minimum_padding = 1,
                maximum_padding = 5,
                maximum_length = 15,
                sort_by = 'insert_at_end',
            },
            -- Highlight colors (Solarized Dark)
            highlights = {
                fill = { fg = '#073642', bg = '#073642' },
                -- Inactive
                background = { fg = '#586e75', bg = '#073642' },
                close_button = { fg = '#586e75', bg = '#073642' },
                separator = { fg = '#586e75', bg = '#073642' },
                modified = { fg = '#b58900', bg = '#073642' },
                duplicate = { fg = '#586e75', bg = '#073642' },
                -- Visible (in splits, not focused)
                buffer_visible = { fg = '#586e75', bg = '#002b36' },
                close_button_visible = { fg = '#586e75', bg = '#002b36' },
                separator_visible = { fg = '#586e75', bg = '#002b36' },
                modified_visible = { fg = '#b58900', bg = '#002b36' },
                duplicate_visible = { fg = '#586e75', bg = '#002b36' },
                -- Selected
                buffer_selected = { fg = '#93a1a1', bg = '#002b36', bold = true, italic = false },
                close_button_selected = { fg = '#93a1a1', bg = '#002b36' },
                separator_selected = { fg = '#93a1a1', bg = '#002b36' },
                modified_selected = { fg = '#b58900', bg = '#002b36' },
                duplicate_selected = { fg = '#586e75', bg = '#002b36' },
                indicator_selected = { fg = '#002b36', bg = '#002b36' },
            },
        }
    end,
}
