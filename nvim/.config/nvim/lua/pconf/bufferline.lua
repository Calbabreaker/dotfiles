function close_buffer(target_buffer)
    if vim.bo.modified then
        return vim.api.nvim_err_writeln("Cannot close buffer because of unsaved changes!")
    end

    if target_buffer == nil then
        target_buffer = vim.api.nvim_get_current_buf()
    end

    -- get list of windows IDs with that have the target_buffer open
    local windows = vim.tbl_filter(
        function(win) return vim.api.nvim_win_get_buf(win) == target_buffer end,
        vim.api.nvim_list_wins()
    )

    local excluded_filetypes = { "NvimTree", "fugitive" }

    -- get list of active buffers which are not excluded
    local buffers = vim.tbl_filter(
        function(buffer)
            if not vim.api.nvim_buf_is_loaded(buffer) then return false end

            local filetype = vim.api.nvim_buf_get_option(buffer, "filetype")
            for _, excluded_filetype in pairs(excluded_filetypes) do
                if filetype == excluded_filetype then return false end
            end

            return true
        end,
        vim.api.nvim_list_bufs()
    )

    if #windows > 0 and #buffers > 1 then
        -- go through buffers and find the next buffer from the target and switch
        -- to that before closing the current buffer
        for i, buffer in ipairs(buffers) do
            if buffer == target_buffer then
                local next_buffer = buffers[i % #buffers + 1]
                for _, win in ipairs(windows) do
                    vim.api.nvim_win_set_buf(win, next_buffer)
                end
            end
        end
    end

    local modifier = ""
    if vim.api.nvim_buf_get_option(target_buffer, "buftype") then
        modifier = "!"
    end

    vim.cmd(string.format("bdelete%s %d", modifier, target_buffer))
end

register_mappings("tn", { noremap = true, silent = true }, {
    -- move to previous/next
    { "<A-.>", "<cmd>BufferLineCycleNext<CR>" },
    { "<A-,>", "<cmd>BufferLineCyclePrev<CR>" },

    -- re-order to previous/next
    { "<A->>", "<cmd>BufferLineMoveNext<CR>" },
    { "<A-<>", "<cmd>BufferLineMovePrev<CR>" },

    -- goto buffer at position
    { "<A-1>", "<cmd>BufferGoto 1<CR>" },
    { "<A-2>", "<cmd>BufferGoto 2<CR>" },
    { "<A-3>", "<cmd>BufferGoto 3<CR>" },
    { "<A-4>", "<cmd>BufferGoto 4<CR>" },
    { "<A-5>", "<cmd>BufferGoto 5<CR>" },
    { "<A-6>", "<cmd>BufferGoto 6<CR>" },
    { "<A-7>", "<cmd>BufferGoto 7<CR>" },
    { "<A-8>", "<cmd>BufferGoto 8<CR>" },
    { "<A-9>", "<cmd>BufferLast<CR>" },

    -- close buffer
    { "<A-c>", "<cmd>lua close_buffer()<CR>" },
    { "<A-C>", "<cmd>BufferLineCloseLeft<CR> <cmd>BufferLineCloseRight<CR>" },

    -- magic buffer picking mode
    { "<A-p>", "<cmd>BufferLinePick<CR>" },
    { "<Leader>bd", "<cmd>BufferLineSortByDirectory<CR>" },
    { "<Leader>be", "<cmd>BufferLineSortByExtension<CR>" },
})

require("bufferline").setup({
    options = {
        offsets = {{
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center"
        }},
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diagnostics_dict, _)
            local lsp_icons = {
                other = " ",
                info = " ",
                warning = " ",
                error = " ",
            }

            local diag = " "
            for err, count in pairs(diagnostics_dict) do
                local icon = lsp_icons[err]
                diag = diag..count..icon
            end
            return diag
        end,
        close_command = function(buffer)
            close_buffer(buffer)
        end,
        right_mouse_command = "vertical sbuffer %d",
        show_close_icon = false,
    },
})
