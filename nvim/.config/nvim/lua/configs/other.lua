return {
	blankline = function()
		require("ibl").setup({
			indent = { char = "▏" },
            exclude = {
                filetypes = { "NvimTree", "help", "packer", "alpha", "man", "lsp-installer" },
                buftypes = { "terminal" }
            },
            scope = {
                enabled = true,
            },
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
				WinSeparator = { fg = "$bg_d", bg = "$bg_d" },
				LspReferenceRead = { bg = lspHoverColor, fmt = "none" },
				LspReferenceText = { bg = lspHoverColor, fmt = "none" },
				LspReferenceWrite = { bg = lspHoverColor, fmt = "none" },
				CursorLine = { bg = lineColor },
				ColorColumn = { bg = lineColor },
				IblIndent = { fg = "#424855", fmt = "nocombine" },
				IblScope = { fg = "#6a7285", fmt = "nocombine" },
			},
		})

		onedark.load()
	end,

	lazygit = function()
		require("toggleterm").setup({
            persist_mode = false
        })

		local Terminal = require("toggleterm.terminal").Terminal
		LazyGit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
			float_opts = {
				border = "double",
			},
		})
	end,
}
