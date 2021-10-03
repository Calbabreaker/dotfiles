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
        description = { "  Recent Projects      " },
        command = "Telescope projects",
    },
    find_files = {
        description = { "  Find File            " },
        command = "Telescope find_files",
    },
    recent_files = {
        description = { "  Recently Opened Files" },
        command = "Telescope oldfiles",
    },
    find_word = {
        description = { "  Find Word            " },
        command = "Telescope live_grep",
    },
    new_file = {
        description = { "  New File             " },
        command = "DashboardNewFile",
    },
}
