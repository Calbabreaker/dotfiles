vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_disable_window_picker = 1

vim.g.nvim_tree_show_icons = {
	git = 0,
	folders = 1,
	files = 1,
	folder_arrows = 1,
}

vim.g.nvim_tree_icons = {
	default = "",
	symlink = "",
}

local nvimtree = require("nvim-tree")
local view = require("nvim-tree.view")

nvimtree.setup({
	auto_close = true,
	diagnostics = {
		enable = true,
	},
	view = {
		width = 30,
		side = "left",
		auto_resize = false,
	},
	filters = {
		dotfiles = false,
		custom = { ".git", "node_modules", ".cache" },
	},
	git = {
		enable = true,
		ignore = false,
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
})

-- closes current buffer while not cycling to nvim-tree window
function BufferClose()
	local bufferline = require("bufferline")

	local explorer_window = view.get_winnr()
	local was_explorer_open = vim.api.nvim_win_is_valid(explorer_window)
	local buffer_to_delete = vim.api.nvim_get_current_buf()

	if was_explorer_open then
		-- switch to previous buffer (tracked by bufferline)
		bufferline.cycle(-1)
	end

	-- delete initially open buffer
	vim.cmd("bdelete! " .. buffer_to_delete)
end
