vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_highlight_opened_files = 1
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

nvimtree.setup({
	diagnostics = {
		enable = true,
	},
	view = {
		width = 30,
		side = "left",
		auto_resize = false,
		mappings = {
			list = {
				{
					key = "<C-e>",
					action = "",
				},
				{
					key = "D",
					action = "remove",
				},
				{
					key = "d",
					action = "trash",
				},
			},
		},
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
