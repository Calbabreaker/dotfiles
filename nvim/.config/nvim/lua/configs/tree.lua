local nvimtree = require("nvim-tree")

nvimtree.setup({
	diagnostics = {
		enable = true,
	},
	view = {
		width = 30,
		side = "left",
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
		custom = { "^.git$", "^node_modules$", "^.cache$" },
	},
	git = {
		enable = true,
		ignore = false,
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	renderer = {
		highlight_git = true,
		group_empty = true,
		highlight_opened_files = "1",
		icons = {
			show = {
				git = false,
			},
		},
	},
})
