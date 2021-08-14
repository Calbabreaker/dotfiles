vim.g.nvim_tree_allow_resize = 1
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_auto_ignore_ft = { "startify", "dashboard" }
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_side = "left"
vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_width = 30

vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 1,
    folder_arrows = 1,
}

vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
}

local view = require("nvim-tree.view")
local tree = require("nvim-tree")
local buffstate = require("bufferline.state")

function ToggleTree()
    if view.win_open() then
        buffstate.set_offset(0)
        tree.close()
    else
        buffstate.set_offset(vim.g.nvim_tree_width, "File Explorer")
        tree.find_file(true)
    end
end

RegisterMappings("n", {}, {
    { "<Leader>n", "<cmd>lua ToggleTree()<CR>" },
})
