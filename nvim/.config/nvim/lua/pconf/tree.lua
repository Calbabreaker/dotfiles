vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_indent_markers = 1

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
local nvimtree = require("nvim-tree")
local buffstate = require("bufferline.state")

local tree_width = 30

nvimtree.setup({
    auto_close = true,
    lsp_diagnostics = true,
    view = {
        width = tree_width,
        side = "left",
        auto_resize = false,
    }
})

function ToggleTree()
    if view.win_open() then
        buffstate.set_offset(0)
        nvimtree.close()
    else
        buffstate.set_offset(tree_width, "File Explorer")
        nvimtree.find_file(true)
    end
end

RegisterMappings("n", {}, {
    { "<C-e>", "<cmd>lua ToggleTree()<CR>" },
})
