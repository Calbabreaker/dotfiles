return {
	blankline = function()
		require("indent_blankline").setup({
			char = "▏",
			buftype_exclude = { "terminal" },
			filetype_exclude = { "NvimTree", "help", "packer", "startify", "dashboard", "man" },
			show_current_context = true,
			show_trailing_blankline_indent = false,
		})

		vim.api.nvim_command("highlight IndentBlanklineChar guifg=#424855 gui=nocombine")
		vim.api.nvim_command("highlight IndentBlanklineContextChar guifg=#7e889e gui=nocombine")
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

		require("nvim-autopairs.completion.cmp").setup({
			map_cr = true, --  map <CR> on insert mode
			map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
			auto_select = true, -- automatically select the first item
			insert = false, -- use insert confirm behavior instead of replace
		})
	end,

	colorscheme = function()
		vim.g.onedark_disable_terminal_colors = true
		vim.g.onedark_darker_diagnostics = false
		vim.api.nvim_command("colorscheme onedark")

		local colors = require("onedark/colors")
		-- disable end of buffer chars
		vim.api.nvim_command("highlight EndOfBuffer guifg=" .. colors.bg0)
		vim.api.nvim_command("highlight NvimTreeEndOfBuffer guifg=" .. colors.bg_d)

		vim.api.nvim_command("highlight DiagnosticError guifg=LspDiagnosticsDefaultError")
		vim.api.nvim_command("highlight DiagnosticHint guifg=LspDiagnosticsDefaultHint")
	end,
}
