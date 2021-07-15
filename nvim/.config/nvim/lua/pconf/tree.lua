vim.g.nvim_tree_allow_resize = 1
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_auto_ignore_ft = { "startify", "dashboard" }
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_side = "left"
vim.g.nvim_tree_update_cwd = 1

vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 1,
    folder_arrows = 1,
}

vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
    folder = {
        arrow_open = "",
        arrow_closed = "",
        default =  "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
    },
    lsp = {
        hint = "",
        info = "",
        warning = "",
        error = "",
    }
}

register_mappings("n", { noremap = true, silent = true }, {
    { "<Leader>n", "<cmd>NvimTreeToggle<CR>"},
    { "<Leader>r", "<cmd>NvimTreeRefresh<CR>"},
    { "<Leader>f", "<cmd>NvimTreeFindFile<CR>"},
})

