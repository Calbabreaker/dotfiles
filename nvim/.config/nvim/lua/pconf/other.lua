M = {}

function M.blankline()
    require("indent_blankline").setup {
        char = "┊",
        buftype_exclude = {"terminal"},
        filetype_exclude = { "NvimTree", "help", "packer", "startify" },
        use_treesiter = true,
        show_current_context = true,
    }
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

function M.sneak()
    vim.g["sneak#label"] = 1
    register_mappings("n", {}, {
        { "f", "<Plug>Sneak_f" },
        { "F", "<Plug>Sneak_F" },
        { "t", "<Plug>Sneak_t" },
        { "T", "<Plug>Sneak_T" },
    })
end

return M
