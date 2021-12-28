local loaded, wk = pcall(require, "which-key")
if not loaded then
	return
end

-- register mappings on a mode or multiple (as a string)
-- w mode uses which key (note that every mapping needs a description in that mode)
function RegisterMappings(mode, mappings, options)
	-- split up the string
	if #mode > 1 then
		for i = 1, #mode do
			RegisterMappings(mode:sub(i, i), mappings, options)
		end
		return
	end

	if mode == "w" then
		wk.register(mappings, options)
	else
		for key, mapping in pairs(mappings) do
			local cmd = mapping[1]
			-- add terminal escape
			if mode == "t" then
				cmd = "<C-\\><C-N>" .. cmd
			end

			-- convert " " to "" (normal, operater pending, etc... mapping)
			if mode == " " then
				mode = ""
			end

			local opts = vim.tbl_deep_extend("force", { silent = true, noremap = true }, options or {})
			vim.api.nvim_set_keymap(mode, key, cmd, opts)
		end
	end
end

function DefineAugroup(name, definitions)
	vim.api.nvim_command("augroup " .. name)
	vim.api.nvim_command("autocmd!")

	for _, definition in pairs(definitions) do
		vim.api.nvim_command("autocmd " .. definition)
	end

	vim.api.nvim_command("augroup end")
end

-- main mappings
RegisterMappings("w", {
	["Y"] = { "y$", "which_key_ignore" },

	-- center cursor while moving
	["n"] = { "nzzzv", "which_key_ignore" },
	["N"] = { "Nzzzv", "which_key_ignore" },
	["J"] = { "mzJ`z", "which_key_ignore" },

	["<A-j>"] = { "<cmd>m .+1<CR>==", "Move current line down" },
	["<A-k>"] = { "<cmd>m .-2<CR>==", "Move current line up" },

	-- general
	["<A-q>"] = { "<cmd>qa!<CR>", "Quit without saving" },
	["<A-s>"] = { "<cmd>noa w<CR>", "Save without formatting" },
	["<A-x>"] = { "<cmd>x<CR>", "Save and quit" },
	["<C-e>"] = { "<cmd>ToggleTree<CR>", "Toggle file explorer" },
	["<C-s>"] = { "<cmd>w<CR>", "Save file" },
	["<C-t>"] = { "<cmd>execute v:count . 'ToggleTerm'<CR>", "Toggle terminal" },
	["<A-r>"] = { "<cmd>e<CR>", "Refresh file" },
	["<A-u>"] = { "<cmd>edit!<CR>", "Revert all edits since saved" },

	-- lsp
	["[g"] = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Go to next diagnostic" },
	["]g"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Go to previous diagnostic" },
	["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
	["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
	["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
	["gR"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Populate quick fix with references" },
	["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show signature (hover)" },
	["<space>D"] = { "<cmd>lua vim.lsp.buf.type_definition()<CR>" },
	["<space>d"] = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>" },

	-- git gutter
	["]h"] = { "<cmd>lua require('gitsigns.actions').next_hunk()<CR>", "Next git hunk" },
	["[h"] = { "<cmd>lua require('gitsigns.actions').prev_hunk()<CR>", "Previous git hunk" },

	-- quick fix
	["<C-n>"] = { "<cmd>cnext<CR>zzzv", "Go to next item in quick fix list" },
	["<C-p>"] = { "<cmd>cprev<CR>zzzv", "Go to previous item in quick fix list" },
	["<C-q>"] = { "<cmd>call ToggleQuickFixList()<CR>", "Toggle quick fix list" },

	-- buffers
	["<A-.>"] = { "<cmd>BufferNext<CR>", "Go to next tab" },
	["<A-,>"] = { "<cmd>BufferPrevious<CR>", "Go to previous tab" },
	["<A->>"] = { "<cmd>BufferMoveNext<CR>", "Move previous tab" },
	["<A-<>"] = { "<cmd>BufferMovePrevious<CR>", "Move previous tab" },
	["<A-1>"] = { "<cmd>BufferGoto 1<CR>", "Go to tab 1" },
	["<A-2>"] = { "<cmd>BufferGoto 2<CR>", "Go to tab 2" },
	["<A-3>"] = { "<cmd>BufferGoto 3<CR>", "Go to tab 3" },
	["<A-4>"] = { "<cmd>BufferGoto 4<CR>", "Go to tab 4" },
	["<A-5>"] = { "<cmd>BufferGoto 5<CR>", "Go to tab 5" },
	["<A-6>"] = { "<cmd>BufferGoto 6<CR>", "Go to tab 6" },
	["<A-7>"] = { "<cmd>BufferGoto 7<CR>", "Go to tab 7" },
	["<A-8>"] = { "<cmd>BufferGoto 8<CR>", "Go to tab 8" },
	["<A-9>"] = { "<cmd>BufferLast<CR>", "Go to last tab" },
	["<A-c>"] = { "<cmd>BufferClose<CR>", "Close current tab" },
	["<A-C>"] = { "<cmd>BufferCloseAllButCurrent<CR>", "Close all other tabs" },
	["<A-p>"] = { "<cmd>BufferPick<CR>", "Pick a tab" },

	["<Leader>"] = {
		g = {
			name = "Git",
			g = { "<cmd>Git<CR>", "Open git fugitive" },
			p = { "<cmd>Git push<CR>", "Git push to default remote" },
			h = { "<cmd>diffget //2<CR>", "Get change to the left of merge conflict" },
			l = { "<cmd>diffget //3<CR>", "Get change to the right of merge conflict" },
			b = { "<cmd>Telescope git_branches<CR>", "Checkout branches" },
			c = { "<cmd>Telescope git_commits<CR>", "Checkout commits" },
			C = { "<cmd>Telescope git_bcommits<CR>", "Checkout commits of the current file" },
			s = { "<cmd>Telescope git_stash<CR>", "Checkout stash" },
			o = { "<cmd>Telescope git_status<CR>", "Open changed files" },
		},
		h = {
			name = "Git hunk",
			U = { "<cmd>lua require('gitsigns').reset_buffer_index()<CR>", "Reset buffer index" },
			b = { "<cmd>lua require('gitsigns').blame_line(true)<CR>", "Show git blame" },
			p = { "<cmd>lua require('gitsigns').preview_hunk()<CR>", "Preview hunk" },
			s = { "<cmd>lua require('gitsigns').stage_hunk()<CR>", "Stage hunk" },
			S = { "<cmd>lua require('gitsigns').stage_buffer()<CR>", "Stage buffer" },
			u = { "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", "Undo stage" },
			r = { "<cmd>lua require('gitsigns').reset_hunk()<CR>", "Reset hunk" },
			R = { "<cmd>lua require('gitsigns').reset_buffer()<CR>", "Reset buffer" },
		},
		t = {
			name = "Open terminal",
			t = { "<cmd>ToggleTerm size=25 directory=horizontal<CR>", "Open horizontal terminal" },
			w = { "<cmd>ToggleTerm direction=tab<CR>", "Open terminal in new tab" },
			f = { "<cmd>ToggleTerm direction=float<CR>", "Open floating terminal" },
			o = { "<cmd>ToggleTermOpenAll<CR>", "Open all closed terminals" },
		},
		b = {
			name = "Buffers",
			d = { "<cmd>BufferOrderByDirectory<CR>", "Sort buffers by directory" },
			l = { "<cmd>BufferOrderByLanguage<CR>", "Sort buffers by programming language" },
			f = { "<cmd>Telescope buffers<CR>", "Find buffers" },
			n = { "<cmd>ene <BAR> startinsert <CR>", "New empty buffer" },
		},
		o = { "<cmd>Telescope find_files<CR>", "Select and open files" },
		f = {
			name = "Find",
			t = { "<cmd>Telescope filetypes<CR>", "Find and set buffer filetype" },
			m = { "<cmd>Telescope man_pages<CR>", "Find man pages" },
			o = { "<cmd>Telescope oldfiles<CR>", "Find previously opened files" },
			p = { "<cmd>Telescope projects<CR>", "Find projects" },
			f = { "<cmd>Telescope<CR>", "Find finding functions" },
			s = { "<cmd>Telescope live_grep<CR>", "Search for text" },
			c = {
				"<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<CR>",
				"Find and select color scheme",
			},
			r = { "<cmd>Telescope commands<CR>", "Find and run command" },
		},
		l = {
			name = "LSP",
			f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format buffer" },
			a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
			r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol" },
			i = { "<cmd>LspInfo<CR>", "Show LSP info" },
			d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Show document diagnostics" },
			D = { "<cmd>Telescope diagnostics<cr>", "Show workspace diagnostics" },
			s = { "<cmd>Telescope lsp_document_symbols<cr>", "Show document symbols" },
			S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Show workspace symbols" },
			l = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "Show diagnostics on line" },
		},
		p = {
			name = "Packer (plugin manager)",
			s = { "<cmd>PackerSync<CR>", "Packer sync" },
			i = { "<cmd>PackerStatus<CR>", "Show plugins info" },
			c = { "<cmd>PackerCompile<CR>", "Make packer_compiled.lua" },
		},
		[";"] = { "<cmd>Alpha<CR>", "Open dashboard" },
	},
}, {
	silent = false,
})

RegisterMappings("nic", {
	["<C-c>"] = { "<ESC>" },
	["<ESC>"] = { "<ESC>:noh<CR>" },
}, {
	noremap = false,
})

RegisterMappings("wit", {
	-- make window navigation easier
	["<C-h>"] = { "<ESC><C-w>h", "Move to left window" },
	["<C-j>"] = { "<ESC><C-w>j", "Move to bottom window" },
	["<C-k>"] = { "<ESC><C-w>k", "Move to top window" },
	["<C-l>"] = { "<ESC><C-w>l", "Move to right window" },

	-- resize using arrow keys
	["<C-Left>"] = { "<cmd>vertical resize +3<CR>", "Scale window left" },
	["<C-Right>"] = { "<cmd>vertical resize -3<CR>", "Scale window right" },
	["<C-Up>"] = { "<cmd>resize +3<CR>", "Scale window up" },
	["<C-Down>"] = { "<cmd>resize -3<CR>", "Scale window down" },

	["<C-z>"] = { "<ESC>", "<ESC>" },
})

RegisterMappings("i", {
	-- break undos
	[","] = { ",<C-g>u" },
	["."] = { ".<C-g>u" },
	["!"] = { "!<C-g>u" },
	["?"] = { "?<C-g>u" },
	["("] = { "(<C-g>u" },

	["<A-j>"] = { "<ESC>:m .+1<CR>==i" },
	["<A-k>"] = { "<ESC>:m .-2<CR>==i" },
	["<C-s>"] = { "<cmd>w<CR>" },
})

RegisterMappings("v", {
	["<A-j>"] = { ":m '>+1<CR>gv=gv" },
	["<A-k>"] = { ":m '<-2<CR>gv=gv" },
	["<"] = { "<gv" },
	[">"] = { ">gv" },
	["<Leader>hs"] = { "<cmd>lua require('gitsigns').stage_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>" },
	["<Leader>hr"] = { "<cmd>lua require('gitsigns').reset_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>" },
})

DefineAugroup("general_settings", {
	"BufWritePre * :silent lua vim.lsp.buf.formatting_sync()",
	"FileType c,cpp,javascript,javascriptreact,typescript,typescriptreact setlocal commentstring=//\\ %s",

	-- hide stuff when dashboard is open
	"User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2",
	"User AlphaReady set laststatus=0 | autocmd BufUnload <buffer> set laststatus=2",

	-- When editing a file, always jump to the last known cursor position.
	-- Don't do it when the position is invalid, when inside an event handler
	-- (happens when dropping a file on gvim) and for a commit message (it's
	-- likely a different one than last time).
	[[BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]],
})

vim.api.nvim_command([[
    function! ToggleQuickFixList()
        if empty(filter(getwininfo(), 'v:val.quickfix'))
            copen
        else
            cclose
        endif
    endfunction
]])
