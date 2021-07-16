local bufdel = require("bufdelete")

function close_current_buffer()
    bufdel.bufdelete(0)
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
    { "<A-c>", "<cmd>lua close_current_buffer()<CR>" },
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
            bufdel.bufdelete(buffer)
        end,
        right_mouse_command = "vertical sbuffer %d",
        show_close_icon = false,
    },
})
