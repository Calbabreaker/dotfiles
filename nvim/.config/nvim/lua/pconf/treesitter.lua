require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	indent = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["i,"] = "@parameter.inner",
				["a,"] = "@parameter.outer",
				["ia"] = "@statement.inner",
				["aa"] = "@statement.outer",
			},
		},
		swap = {
			enable = true,
			swap_previous = {
				["g,"] = "@parameter.inner",
			},
			swap_next = {
				["g."] = "@parameter.inner",
			},
		},
	},
})
