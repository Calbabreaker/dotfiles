local nvimtree = require("nvim-tree")

local function on_attach(bufnr)
    local api = require('nvim-tree.api')
    local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true } 

    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.del('n', '<C-e>', { buffer = bufnr })
    vim.keymap.set('n', 'D', api.fs.remove, opts)
    vim.keymap.set('n', 'd', api.fs.trash, opts)

end

nvimtree.setup({
    diagnostics = {
        enable = true,
    },
    view = {
        width = 30,
        side = "right",
    },
    filters = {
        dotfiles = false,
        custom = { "^.git$", "^node_modules$", "^.cache$" },
    },
    git = {
        enable = true,
        ignore = false,
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    renderer = {
        highlight_git = true,
        group_empty = true,
        highlight_opened_files = "1",
        icons = {
            show = {
                git = false,
            },
        },
    },
    on_attach = on_attach,
})
