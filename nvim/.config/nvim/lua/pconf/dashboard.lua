vim.g.dashboard_executive = "telescope"

vim.g.dashboard_custom_header = {
	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}

vim.g.dashboard_custom_section = {
	a = {
		description = { "  Recent Projects             SPC S P" },
		command = "Telescope projects",
	},
	b = {
		description = { "  Recently Opened Files       SPC S O" },
		command = "Telescope oldfiles",
	},
	d = {
		description = { "  New File                    SPC B N" },
		command = "enew",
	},
	e = {
		description = { "  Find File                   SPC F  " },
		command = "Telescope find_files",
	},
	f = {
		description = { "  Find Text                   SPC S T" },
		command = "Telescope live_grep",
	},
}
