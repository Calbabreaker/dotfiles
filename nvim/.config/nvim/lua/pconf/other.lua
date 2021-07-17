M = {}

function M.blankline()
    vim.g.indent_blankline_use_treesitter = true
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_blankline_char = "┊"
    vim.g.indent_blankline_filetype_exclude = { "NvimTree", "help", "packer" }
end

function M.colorizer()
    require("colorizer").setup({"*"}, {
        css = true,
    })
end

function M.autopairs()
    require("nvim-autopairs").setup({
      disable_filetype = { "TelescopePrompt" , "vim" },
    })

    require("nvim-autopairs.completion.compe").setup({
        map_cr = true, --  map <CR> on insert mode
        map_complete = true, -- it will auto insert `(` after select function or method item
    })
end

return M
