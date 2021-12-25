local dashboard = require("alpha.themes.dashboard")
local section = dashboard.section
section.header.val = {
	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}
section.header.opts.hl = "String"

local function button(...)
	local config = dashboard.button(...)
	config.opts.hl = "Function"
	config.opts.hl_shortcut = "Number"
	config.opts.width = 30
	return config
end

section.buttons.val = {
	button("p", "  Open Projects", "<cmd>Telescope projects<CR>"),
	button("r", "  Open Recent Files", "<cmd>Telescope oldfiles<CR>"),
	button("n", "  New File", "<cmd>ene <BAR> startinsert <CR>"),
	button("o", "  Open File", "<cmd>Telescope find_files<CR>"),
	button("s", "  Search Text", "<cmd>Telescope live_grep<CR>"),
}

section.footer.val = require("alpha.fortune")()
section.footer.opts.hl = "Comment"

local opts = {
	layout = {
		{ type = "padding", val = 2 },
		section.header,
		{ type = "padding", val = 2 },
		section.buttons,
		section.footer,
	},
	opts = {
		margin = 5,
	},
}

require("alpha").setup(opts)
