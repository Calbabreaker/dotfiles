require("nvim-treesitter.configs").setup({
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true
    },
    context_commentstring = {
        enable = true,
    },
})
