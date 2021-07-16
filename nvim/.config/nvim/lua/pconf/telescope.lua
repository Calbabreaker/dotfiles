local telescope_builtin = require("telescope.builtin")

function find_files()
    telescope_builtin.find_files({
        find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
        previewer = false
    })
end

register_mappings("n", {}, {
    { "<Leader>ff", "<cmd>lua find_files()<CR>" },
    { "<Leader>fg", "<cmd>Telescope live_grep<CR>" },
})

require("telescope").setup({
    defaults = {
        file_ignore_patterns = { ".gitignore", ".git/" },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden"
        },
    }
})
