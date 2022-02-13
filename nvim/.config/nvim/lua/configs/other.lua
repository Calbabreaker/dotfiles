return {
	blankline = function()
		require("indent_blankline").setup({
			char = "▏",
			context_char = "▏",
			buftype_exclude = { "terminal" },
			filetype_exclude = { "NvimTree", "help", "packer", "alpha", "man" },
			show_current_context = true,
			show_trailing_blankline_indent = false,
		})
	end,

	colorizer = function()
		require("colorizer").setup({ "*" }, {
			css = true,
		})
	end,

	autopairs = function()
		require("nvim-autopairs").setup({
			disable_filetype = { "TelescopePrompt", "vim" },
		})

		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
	end,

	treesitter = function()
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
		})
	end,

	bufferline = function()
		require("bufferline").setup({
			options = {
				close_command = function()
					BufferClose()
				end,
				right_mouse_command = function()
					BufferClose()
				end,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						padding = 1,
					},
				},
			},
		})
	end,
}
