return {
    blankline = function()
        require("indent_blankline").setup({
            buftype_exclude = {"terminal"},
            filetype_exclude = { "NvimTree", "help", "packer", "startify", "dashboard" },
            show_current_context = true,
            show_trailing_blankline_indent = false
        })

        vim.api.nvim_command("highlight IndentBlanklineContextChar guifg=#cccccc gui=nocombine")
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

    colorscheme = function()
        vim.g.onedark_disable_terminal_colors = true
        vim.api.nvim_command("colorscheme onedark")

        local colors = require("onedark/colors")
        -- disable end of buffer chars
        vim.api.nvim_command("highlight EndOfBuffer guifg="..colors.bg0)
        vim.api.nvim_command("highlight NvimTreeEndOfBuffer guifg="..colors.bg_d)
    end,
}
