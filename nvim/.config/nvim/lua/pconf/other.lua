return {
    blankline = function()
        require("indent_blankline").setup({
            char = "┊",
            buftype_exclude = {"terminal"},
            filetype_exclude = { "NvimTree", "help", "packer", "startify" },
            show_current_context = true,
            show_trailing_blankline_indent = false
        })
    end,

    colorizer = function()
        require("colorizer").setup({"*"}, {
            css = true,
        })
    end,

    autopairs = function()
        require("nvim-autopairs").setup({
            disable_filetype = { "TelescopePrompt" , "vim" },
        })

        require("nvim-autopairs.completion.compe").setup({
            map_cr = true, --  map <CR> on insert mode
            map_complete = true, -- it will auto insert `(` after select function or method item
        })
    end,

    toggleterm = function()
        require("toggleterm").setup({
            open_mapping = [[<C-t>]],
        })
    end,

    yoink = function()
        vim.g.yoinkSavePersistently = 1
        vim.g.yoinkMoveCursorToEndOfPaste = 1
        vim.g.yoinkSyncNumberedRegisters = 1
    end,
}
