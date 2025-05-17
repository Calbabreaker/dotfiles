local wk_loaded, wk = pcall(require, "which-key")
if not wk_loaded then
    return
end

-- register mappings on a mode or multiple (as a string)
-- w mode uses which key (note that every mapping needs a description in that mode)
local function register_mappings(mode, mappings, options)
    -- split up the string
    if #mode > 1 then
        for i = 1, #mode do
            register_mappings(mode:sub(i, i), mappings, options)
        end
        return
    end

    if mode == "w" then
        wk.add(mappings)
    else
        for _, mapping in ipairs(mappings) do
            local cmd = mapping[2]
            local key = mapping[1]
            -- add terminal escape
            if mode == "t" then
                cmd = "<C-\\><C-N>" .. cmd
            end

            local opts = vim.tbl_deep_extend("force", { silent = true, noremap = true }, options or {})
            vim.api.nvim_set_keymap(mode, key, cmd, opts)
        end
    end
end

vim.api.nvim_del_keymap("n", "gri")
vim.api.nvim_del_keymap("n", "gra")
vim.g.ftplugin_sql_omni_key = "<C-y>"

local function define_augroup(name, definitions)
    vim.api.nvim_command("augroup " .. name)
    vim.api.nvim_command("autocmd!")

    for _, definition in pairs(definitions) do
        vim.api.nvim_command("autocmd " .. definition)
    end

    vim.api.nvim_command("augroup end")
end

-- main mappings
register_mappings("w", {
    { "J",          "mzJ`z",                                                 hidden = true },
    { "N",          "Nzzzv",                                                 hidden = true },
    { "Y",          "y$",                                                    hidden = true },
    { "n",          "nzzzv",                                                 hidden = true },
    { "<C-u>",      "<C-u>zz",                                               hidden = true },
    { "<C-d>",      "<C-d>zz",                                               hidden = true },

    -- LSP
    { "K",          "<cmd>lua vim.lsp.buf.hover({border = 'rounded'})<CR>",  desc = "Show signature (hover)" },
    { "]g",         "<cmd>Lspsaga diagnostic_jump_next<CR>",                 desc = "Go to next diagnostic" },
    { "[h",         "<cmd>lua require('gitsigns.actions').prev_hunk()<CR>",  desc = "Previous git hunk" },
    { "[g",         "<cmd>Lspsaga diagnostic_jump_prev<CR>",                 desc = "Go to previous diagnostic" },
    { "]h",         "<cmd>lua require('gitsigns.actions').next_hunk()<CR>",  desc = "Next git hunk" },
    { "gD",         "<cmd>lua vim.lsp.buf.declaration()<CR>",                desc = "Go to declaration" },
    { "gR",         "<cmd>Lspsaga finder ref<CR>",                           desc = "Show references" },
    { "gd",         "<cmd>Lspsaga goto_definition<CR>",                      desc = "Go to definition" },
    { "gi",         "<cmd>lua vim.lsp.buf.implementation()<CR>",             desc = "Go to implementation" },
    { "gt",         "<cmd>Lspsaga goto_type_definition<CR>",                 desc = "Go to type definition" },

    { "gp",         group = "Peek lsp" },
    { "gpd",        "<cmd>Lspsaga peek_definition<CR>",                      desc = "Peek definition" },
    { "gpt",        "<cmd>Lspsaga peek_type_definition<CR>",                 desc = "Peek type definition" },
    { "gpi",        "<cmd>Lspsaga finder imp<CR>",                           desc = "Show implementation(s)" },

    -- Tabs
    { "<A-,>",      "<cmd>BufferLineCyclePrev<CR>",                          desc = "Go to previous tab" },
    { "<A-.>",      "<cmd>BufferLineCycleNext<CR>",                          desc = "Go to next tab" },
    { "<A-1>",      "<cmd>BufferLineGoToBuffer 1<CR>",                       desc = "Go to tab 1" },
    { "<A-2>",      "<cmd>BufferLineGoToBuffer 2<CR>",                       desc = "Go to tab 2" },
    { "<A-3>",      "<cmd>BufferLineGoToBuffer 3<CR>",                       desc = "Go to tab 3" },
    { "<A-4>",      "<cmd>BufferLineGoToBuffer 4<CR>",                       desc = "Go to tab 4" },
    { "<A-5>",      "<cmd>BufferLineGoToBuffer 5<CR>",                       desc = "Go to tab 5" },
    { "<A-6>",      "<cmd>BufferLineGoToBuffer 6<CR>",                       desc = "Go to tab 6" },
    { "<A-7>",      "<cmd>BufferLineGoToBuffer 7<CR>",                       desc = "Go to tab 7" },
    { "<A-8>",      "<cmd>BufferLineGoToBuffer 8<CR>",                       desc = "Go to tab 8" },
    { "<A-9>",      "<cmd>BufferLineGoToBuffer 9<CR>",                       desc = "Go to tab 9" },
    { "<A-<>",      "<cmd>BufferLineMovePrev<CR>",                           desc = "Move previous tab" },
    { "<A->>",      "<cmd>BufferLineMoveNext<CR>",                           desc = "Move previous tab" },
    { "<A-C>",      "<cmd>lua BufferCloseAllOther()<CR>",                    desc = "Close all other tabs" },
    { "<A-c>",      "<cmd>lua BufferClose()<CR>",                            desc = "Close current tab" },
    { "<A-p>",      "<cmd>BufferLinePick<CR>",                               desc = "Pick a tab" },

    { "<A-q>",      "<cmd>qa!<CR>",                                          desc = "Quit without saving" },
    { "<A-r>",      "<cmd>e<CR>",                                            desc = "Refresh file" },
    { "<A-s>",      "<cmd>noa w<CR>",                                        desc = "Save without formatting" },
    { "<A-u>",      "<cmd>edit!<CR>",                                        desc = "Revert all edits since saved" },
    { "<A-x>",      "<cmd>x<CR>",                                            desc = "Save and quit" },
    { "<C-e>",      "<cmd>NvimTreeFindFileToggle<CR>",                       desc = "Toggle file explorer" },
    { "<C-n>",      "<cmd>cnext<CR>zzzv",                                    desc = "Go to next item in quick fix list" },
    { "<C-p>",      "<cmd>cprev<CR>zzzv",                                    desc = "Go to previous item in quick fix list" },
    { "<C-q>",      "<cmd>call ToggleQuickFixList()<CR>",                    desc = "Toggle quick fix list" },
    { "<C-s>",      "<cmd>w<CR>",                                            desc = "Save file" },
    { "<C-t>",      "<cmd>execute v:count . 'ToggleTerm'<CR>",               desc = "Toggle terminal" },
    { "<C-j>",      "<cmd>m .+1<CR>==",                                      desc = "Move line down" },
    { "<C-k>",      "<cmd>m .-2<CR>==",                                      desc = "Move line up" },

    -- Running stuff
    { "<Leader>r",  group = "Run" },
    { "<Leader>rp", "<cmd>!python3 %<CR>",                                   desc = "Run current file with python" },
    { "<Leader>rd", "<cmd>!deno run %<CR>",                                  desc = "Run current file with deno" },
    { "<Leader>rr", "<cmd>!cargo run<CR>",                                   desc = "Run current file with cargo/rust" },

    -- Tab/buffers manage
    { "<Leader>b",  group = "Buffers" },
    { "<Leader>bd", "<cmd>BufferLineSortByDirectory<CR>",                    desc = "Sort buffers by directory" },
    { "<Leader>bf", "<cmd>Telescope buffers<CR>",                            desc = "Find buffers" },
    { "<Leader>bl", "<cmd>BufferLineSortByExtension<CR>",                    desc = "Sort buffers by file extension" },
    { "<Leader>bn", "<cmd>ene <BAR> startinsert <CR>",                       desc = "New empty buffer" },

    -- Search and find
    { "<Leader>f",  group = "Find" },
    { "<Leader>fc", "<cmd>Telescope colorscheme<CR>",                        desc = "Find and select color scheme" },
    { "<Leader>ff", "<cmd>Telescope<CR>",                                    desc = "Find finding functions" },
    { "<Leader>fm", "<cmd>Telescope man_pages<CR>",                          desc = "Find man pages" },
    { "<Leader>fo", "<cmd>Telescope oldfiles<CR>",                           desc = "Find previously opened files" },
    { "<Leader>fp", "<cmd>Telescope projects<CR>",                           desc = "Find projects" },
    { "<Leader>fr", "<cmd>Telescope commands<CR>",                           desc = "Find and run command" },
    { "<Leader>fs", "<cmd>Telescope live_grep<CR>",                          desc = "Search for text" },
    { "<Leader>ft", "<cmd>Telescope filetypes<CR>",                          desc = "Find and set buffer filetype" },

    -- Git
    { "<Leader>g",  group = "Git" },
    { "<Leader>gC", "<cmd>Telescope git_bcommits<CR>",                       desc = "Checkout commits of the current file" },
    { "<Leader>gb", "<cmd>Telescope git_branches<CR>",                       desc = "Checkout branches" },
    { "<Leader>gc", "<cmd>Telescope git_commits<CR>",                        desc = "Checkout commits" },
    { "<Leader>gb", "<cmd>GitBlameToggle<CR>",                               desc = "Toggle git blame" },
    { "<Leader>gg", "<cmd>lua LazyGit:toggle()<CR>",                         desc = "Open lazygit" },
    { "<Leader>gh", "<cmd>diffget //2<CR>",                                  desc = "Get change to the left of merge conflict" },
    { "<Leader>gl", "<cmd>diffget //3<CR>",                                  desc = "Get change to the right of merge conflict" },
    { "<Leader>go", "<cmd>Telescope git_status<CR>",                         desc = "Open changed files" },
    { "<Leader>gs", "<cmd>Telescope git_stash<CR>",                          desc = "Checkout stash" },

    { "<Leader>h",  group = "Git hunk" },
    { "<Leader>hR", "<cmd>lua require('gitsigns').reset_buffer()<CR>",       desc = "Reset buffer" },
    { "<Leader>hS", "<cmd>lua require('gitsigns').stage_buffer()<CR>",       desc = "Stage buffer" },
    { "<Leader>hU", "<cmd>lua require('gitsigns').reset_buffer_index()<CR>", desc = "Reset buffer index" },
    { "<Leader>hb", "<cmd>lua require('gitsigns').blame_line(true)<CR>",     desc = "Show git blame" },
    { "<Leader>hp", "<cmd>lua require('gitsigns').preview_hunk()<CR>",       desc = "Preview hunk" },
    { "<Leader>hr", "<cmd>lua require('gitsigns').reset_hunk()<CR>",         desc = "Reset hunk" },
    { "<Leader>hs", "<cmd>lua require('gitsigns').stage_hunk()<CR>",         desc = "Stage hunk" },
    { "<Leader>hu", "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>",    desc = "Undo stage" },
    { "<Leader>hd", "<cmd>%!xxd -g 1<CR><cmd>set ft=xxd<CR>",                desc = "Hex dump" },


    { "<Leader>l",  group = "LSP" },
    { "<Leader>lD", "<cmd>Lspsaga show_workspace_diagnostics<cr>",           desc = "Show workspace diagnostics" },
    { "<Leader>lI", "<cmd>LspInstallInfo<CR>",                               desc = "Show LSP install info" },
    { "<Leader>lR", "<cmd>LspRestart<CR>",                                   desc = "Restart Lsp Server" },
    { "<Leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",      desc = "Show workspace symbols" },
    { "<Leader>la", "<cmd>Lspsaga code_action<CR>",                          desc = "Code action" },
    { "<Leader>ld", "<cmd>Lspsaga show_buf_diagnostics<cr>",                 desc = "Show document diagnostics" },
    { "<Leader>ll", "<cmd>Lspsaga show_line_diagnostics<cr>",                desc = "Show line diagnostics" },
    { "<Leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>",       desc = "Format buffer" },
    { "<Leader>li", "<cmd>LspInfo<CR>",                                      desc = "Show LSP info" },
    { "<Leader>lr", "<cmd>Lspsaga rename<CR>",                               desc = "Rename symbol" },
    { "<Leader>ls", "<cmd>Lspsaga outline<cr>",                              desc = "Show document symbol ouline" },
    { "<Leader>lc", "<cmd>Lspsaga incoming_calls<cr>",                       desc = "Show incoming calls" },
    { "<Leader>lC", "<cmd>Lspsaga outgoing_calls<cr>",                       desc = "Show outcoming calls" },
    { "<Leader>o",  "<cmd>Telescope find_files<CR>",                         desc = "Select and open files" },

    { "<Leader>p",  group = "Plugin manager (lazy.nvim)" },
    { "<Leader>pi", "<cmd>Lazy home<CR>",                                    desc = "Show plugins info" },
    { "<Leader>ps", "<cmd>Lazy sync<CR>",                                    desc = "Run install, clean and update" },

    { "<Leader>t",  group = "Open terminal" },
    { "<Leader>tf", "<cmd>ToggleTerm direction=float<CR>",                   desc = "Open floating terminal" },
    { "<Leader>to", "<cmd>ToggleTermOpenAll<CR>",                            desc = "Open all closed terminals" },
    { "<Leader>tt", "<cmd>ToggleTerm size=25 directory=horizontal<CR>",      desc = "Open horizontal terminal" },
    { "<Leader>tw", "<cmd>ToggleTerm direction=tab<CR>",                     desc = "Open terminal in new tab" },
    { "<Leader>;",  "<cmd>Alpha<CR>",                                        desc = "Open dashboard" },
})

register_mappings("nic", {
    { "<C-c>", "<ESC>" },
    { "<ESC>", "<ESC>:noh<CR>" },
}, {
    noremap = false,
})

register_mappings("wit", {
    -- make window navigation easier
    { "<A-h>",     "<ESC><C-w>h",                 desc = "Move to left window" },
    { "<A-j>",     "<ESC><C-w>j",                 desc = "Move to bottom window" },
    { "<A-k>",     "<ESC><C-w>k",                 desc = "Move to top window" },
    { "<A-l>",     "<ESC><C-w>l",                 desc = "Move to right window" },

    -- resize using arrow keys
    { "<C-Left>",  "<cmd>vertical resize +3<CR>", desc = "Scale window left" },
    { "<C-Right>", "<cmd>vertical resize -3<CR>", desc = "Scale window right" },
    { "<C-Up>",    "<cmd>resize +3<CR>",          desc = "Scale window up" },
    { "<C-Down>",  "<cmd>resize -3<CR>",          desc = "Scale window down" },

    { "<C-z>",     "<ESC>",                       desc = "<ESC>" },
})

register_mappings("i", {
    { "<A-j>", "<ESC>:m .+1<CR>==i" },
    { "<A-k>", "<ESC>:m .-2<CR>==i" },
    { "<C-s>", "<cmd>w<CR>" },
})

register_mappings("v", {
    { "<C-j>",      ":m '>+1<CR>gv=gv" },
    { "<C-k>",      ":m '<-2<CR>gv=gv" },
    { "<",          "<gv" },
    { ">",          ">gv" },
    { "<Leader>hs", "<cmd>lua require('gitsigns').stage_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>" },
    { "<Leader>hr", "<cmd>lua require('gitsigns').reset_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>" },
})

define_augroup("general_settings", {
    "BufWritePre * :silent lua vim.lsp.buf.format()",
    "FileType c,cpp,javascriptreact,typescript,typescriptreact,dart setlocal commentstring=//\\ %s",
    "FileType luau setlocal commentstring=--\\ %s",
    "FileType tex setlocal indentexpr&",
    "BufRead,BufNewFile *.wgsl set filetype=wgsl",
    "BufRead,BufNewFile *.luau set filetype=luau",
    "BufRead,BufNewFile *.dart set shiftwidth=2",
    [[BufWritePost *.dart silent execute '!kill -SIGUSR1 $(pgrep -f "[f]lutter_tool.*run")']],

    -- Hide stuff when dashboard is open
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
