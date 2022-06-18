local bufferline = require("bufferline")
local view = require("nvim-tree.view")

-- Closes current buffer without not cycling to nvim-tree window
function BufferClose()
	local explorer_window = view.get_winnr()
	local buffer_to_delete = vim.api.nvim_get_current_buf()
	if explorer_window ~= nil then
		-- Switch to previous buffer (tracked by bufferline)
		bufferline.cycle(-1)
	end

	-- Delete initially open buffer
	vim.api.nvim_command("bdelete! " .. buffer_to_delete)
end

bufferline.setup({
	options = {
		close_command = BufferClose,
		right_mouse_command = BufferClose,
		always_show_bufferline = false,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				padding = 1,
			},
		},
	},
})
