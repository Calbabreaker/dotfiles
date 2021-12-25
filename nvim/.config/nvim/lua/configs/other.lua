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

	colorscheme = function()
		vim.g.onedark_disable_terminal_colors = true
		vim.g.onedark_darker_diagnostics = false
		vim.g.onedark_hide_ending_tildes = true
		vim.api.nvim_command("colorscheme onedark")

		local colors = require("onedark/colors")

		-- have one character border in nvim-tree to make it look good
		vim.api.nvim_command(string.format("highlight NvimTreeVertSplit guifg=%s guibg=%s", colors.bg_d, colors.bg_d))

		-- have unfocused tab not look weird
		vim.api.nvim_command("highlight TabLineSel guibg=TabLineFill guifg=TabLineFill")

		vim.api.nvim_command("highlight NormalFloat guifg=Normal guibg=Normal")
		vim.api.nvim_command("highlight LspReferenceRead guibg=#31353f gui=none")
		vim.api.nvim_command("highlight LspReferenceText guibg=#31353f gui=none")
		vim.api.nvim_command("highlight LspReferenceWrite guibg=#31353f gui=none")
		vim.api.nvim_command("highlight CursorLine guibg=#2c3039")
		vim.api.nvim_command("highlight ColorColumn guibg=#2c3039")

		vim.api.nvim_command("highlight IndentBlanklineChar guifg=#424855 gui=nocombine")
		vim.api.nvim_command("highlight IndentBlanklineContextChar guifg=#6a7285 gui=nocombine")
	end,
}
