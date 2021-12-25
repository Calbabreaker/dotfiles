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
	config.opts.keymap = nil
	config.opts.width = 30
	return config
end

section.buttons.val = {
	button("p", "  Open Projects", "<cmd>Telescope projects"),
	button("r", "  Open Recent Files", "<cmd>Telescope oldfiles"),
	button("n", "  New File", "<cmd>ene <BAR> startinsert <CR>"),
	button("f", "  Find Files", "<cmd>Telescope find_files"),
	button("s", "  Search for text", "<cmd>Telescope live_grep"),
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
