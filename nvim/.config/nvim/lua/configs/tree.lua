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

local view = require("nvim-tree.view")
local nvimtree = require("nvim-tree")
local buffstate = require("bufferline.state")

local tree_width = 30

nvimtree.setup({
	auto_close = true,
	diagnostics = {
		enable = true,
	},
	view = {
		width = tree_width,
		side = "left",
		auto_resize = false,
	},
	filters = {
		dotfiles = false,
		custom = { ".git", "node_modules", ".cache" },
	},
	git = {
		enable = true,
		ignore = true,
	},
})

require("nvim-tree.lib").toggle_ignored()

function ToggleTree()
	if view.win_open() then
		buffstate.set_offset(0)
		nvimtree.close()
	else
		buffstate.set_offset(tree_width + 1, "File Explorer")
		nvimtree.find_file(true)
	end
end

vim.api.nvim_command([[command! ToggleTree lua ToggleTree()]])
