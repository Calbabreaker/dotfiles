local bufferline = require("bufferline")

local function should_close(bufnr)
    local modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })
    local modifiable = vim.api.nvim_get_option_value("modifiable", { buf = bufnr })
    return not modified and modifiable
end

-- Closes current buffer
function BufferClose(bufnr)
    local buffer_to_delete = bufnr and bufnr or vim.api.nvim_get_current_buf()
    if should_close(buffer_to_delete) then
        bufferline.cycle(-1)
        vim.api.nvim_buf_delete(buffer_to_delete, {})
    end
end

function BufferCloseAllOther()
    local buffers = vim.api.nvim_list_bufs()

    for _, bufnr in ipairs(buffers) do
        local current_buffer = bufnr == vim.api.nvim_get_current_buf();

        if not current_buffer and should_close(bufnr) then
            vim.api.nvim_buf_delete(bufnr, {})
        end
    end
end

bufferline.setup({
    options = {
        close_command = BufferClose,
        right_mouse_command = BufferClose,
        always_show_bufferline = true,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                padding = 1,
            },
        },
    },
})
