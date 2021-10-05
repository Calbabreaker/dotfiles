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
	recent_projects = {
		description = { "  Recent Projects             SPC S P" },
		command = "Telescope projects",
	},
	find_files = {
		description = { "  Find File                   SPC F  " },
		command = "Telescope find_files",
	},
	recent_files = {
		description = { "  Recently Opened Files       SPC S O" },
		command = "Telescope oldfiles",
	},
	find_word = {
		description = { "  Find Text                   SPC S T" },
		command = "Telescope live_grep",
	},
	new_file = {
		description = { "  New File                    SPC B N" },
		command = "enew",
	},
}
