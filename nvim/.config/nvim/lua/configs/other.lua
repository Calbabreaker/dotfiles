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
		local lspHoverColor = "#333741"
		local lineColor = "#2c3039"

		local onedark = require("onedark")
		onedark.setup({
			term_colors = false,
			diagnostics = {
				darker = false,
			},
			highlights = {
				TabLineSel = { fg = "fg", bg = "bg" },
				BufferVisibleSign = { fg = "$red", bg = "bg" },
				NormalFloat = { fg = "Normal", bg = "Normal" },
				LspReferenceRead = { bg = lspHoverColor, gui = "none" },
				LspReferenceText = { bg = lspHoverColor, gui = "none" },
				LspReferenceWrite = { bg = lspHoverColor, gui = "none" },
				CursorLine = { bg = lineColor },
				CursorColumn = { bg = lineColor },
				IndentBlanklineChar = { fg = "#424855", gui = "nocombine" },
				IndentBlanklineContextChar = { fg = "#6a7285", gui = "nocombine" },
			},
		})

		onedark.load()
	end,
}
