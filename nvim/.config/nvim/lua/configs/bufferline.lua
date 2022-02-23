local bufferline = require("bufferline")
local view = require("nvim-tree.view")

-- closes current buffer without not cycling to nvim-tree window
function BufferClose()
	local explorer_window = view.get_winnr()
	local was_explorer_open = vim.api.nvim_win_is_valid(explorer_window)
	local buffer_to_delete = vim.api.nvim_get_current_buf()

	if was_explorer_open then
		-- switch to previous buffer (tracked by bufferline)
		bufferline.cycle(-1)
	end

	-- delete initially open buffer
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
