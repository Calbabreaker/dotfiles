local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

function FindFiles()
    builtin.find_files({
        find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
        previewer = false
    })
end

RegisterMappings("n", {}, {
    { "<Leader>fB", "<cmd>Telescope git_branches<CR>" },
    { "<Leader>fb", "<cmd>Telescope buffers<CR>" },
    { "<Leader>fc", "<cmd>Telescope git_commits<CR>" },
    { "<Leader>ff", "<cmd>lua FindFiles()<CR>" },
    { "<Leader>fg", "<cmd>Telescope live_grep<CR>" },
    { "<Leader>fh", "<cmd>Telescope git_stash<CR>" },
    { "<Leader>ft", "<cmd>Telescope filetypes<CR>" },
})

require("telescope").setup({
    defaults = {
        file_ignore_patterns = { ".gitignore", ".git/", "yarn.lock", "package-lock.json"},
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
        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-c>"] = actions.close,
                ["<esc>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<CR>"] = actions.select_default + actions.center,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
        },
    }
})
