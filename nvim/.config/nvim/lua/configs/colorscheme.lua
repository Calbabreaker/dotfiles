local lspHoverColor = "#333741"
local lineColor = "#2c3039"

local onedark = require("onedark")
onedark.setup({
	term_colors = false,
	diagnostics = {
		darker = false,
	},
	highlights = {
		NormalFloat = { fg = "Normal", bg = "Normal" },
		LspReferenceRead = { bg = lspHoverColor, fmt = "none" },
		LspReferenceText = { bg = lspHoverColor, fmt = "none" },
		LspReferenceWrite = { bg = lspHoverColor, fmt = "none" },
		CursorLine = { bg = lineColor },
		ColorColumn = { bg = lineColor },
		IndentBlanklineChar = { fg = "#424855", fmt = "nocombine" },
		IndentBlanklineContextChar = { fg = "#6a7285", fmt = "nocombine" },
	},
})

onedark.load()
