require("nvim-treesitter.configs").setup({
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    -- aditional can be installed using TSInstall language
    ensure_installed = {"html", "css", "javascript", "typescript", "json"},
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
    },
    context_commentstring = {
        enable = true,
    },
})
