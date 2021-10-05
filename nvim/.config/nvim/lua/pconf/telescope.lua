local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local telescope = require("telescope")

function FindFile()
	builtin.find_files({
		find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
	})
end

vim.api.nvim_command([[ command! FindFile lua FindFile()]])

telescope.setup({
	defaults = {
		file_ignore_patterns = { ".gitignore", ".git/", "yarn.lock", "package-lock.json" },
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
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
	},
})

telescope.load_extension("projects")
