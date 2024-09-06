local bufferline = require("bufferline")
local tree_view = require("nvim-tree.view")

-- Closes current buffer without cycling to nvim-tree window
function BufferClose()
    local buffer_to_delete = vim.api.nvim_get_current_buf()
    if tree_view.get_winnr() ~= nil then
        -- Switch to previous buffer (tracked by bufferline)
        bufferline.cycle(-1)
    end

    -- Delete initially open buffer
    vim.api.nvim_buf_delete(buffer_to_delete, {})
end

function BufferCloseAllOther()
    local buffers = vim.api.nvim_list_bufs()
    for _, bufnr in ipairs(buffers) do
        local is_modifiable = vim.api.nvim_buf_get_option(bufnr, 'modifiable')
        if bufnr ~= vim.api.nvim_get_current_buf() and is_modifiable then
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
