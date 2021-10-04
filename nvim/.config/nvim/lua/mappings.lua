local wk = require("which-key")

-- register mappings on a mode or multiple (as a string)
function RegisterMappings(mode, mappings, options)
    -- split up the string
    if #mode > 1 then
        for i = 1, #mode do
            RegisterMappings(mode:sub(i, i), mappings, options)
        end
        return
    end

    -- use which-key for normal mode because it doesn't like other modes
    if mode == "n" then
        wk.register(mappings, options)
    else
        for key, mapping in pairs(mappings) do
            local cmd = mapping[1]
            -- add terminal escape
            if mode == "t" then
                cmd = "<C-\\><C-N>"..cmd
            end

            -- convert " " to "" (normal, operater pending, etc... mapping)
            if mode == " " then mode = "" end

            local opts = vim.tbl_deep_extend("force", { silent = true, noremap = true }, options or {})
            vim.api.nvim_set_keymap(mode, key, cmd, opts)
        end
    end
end

function DefineAugroup(name, definitions)
    vim.api.nvim_command("augroup "..name)
    vim.api.nvim_command "autocmd!"

    for _, definition in pairs(definitions) do
        vim.api.nvim_command("autocmd "..definition)
    end

    vim.api.nvim_command "augroup end"
end

RegisterMappings(" ic", {
    ["<C-c>"] = { "<ESC>", "<ESC>" },
    ["<ESC>"] = { "<ESC>:noh<CR>" },
}, { noremap = false })

RegisterMappings("nit", {
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
})

RegisterMappings("n", {
    -- general
    ["<C-s>"] = { "<cmd>w<CR>", "Save file" },
    ["<C-e>"] = { "<cmd>ToggleTree<CR>", "Toggle file explorer" },
    ["<C-f>"] = { "<cmd>Format<CR>", "Format current buffer" },
    ["<C-t>"] =  { '<cmd>execute v:count . "ToggleTerm"<CR>', "Toggle terminal" },

    ["[g"] = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Go to next diagnostic" },
    ["]g"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Go to previous diagnostic" },
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
    ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
    ["gi"] = { ":lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
    ["gR"] = { ":lua vim.lsp.buf.references()<CR>", "Populate local list with references" },
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show signature (hover)" },
    ["<C-k>"] = { ":lua vim.lsp.buf.signature_help()<CR>", "Show signature help" },
    ["<space>D"] = { ":lua vim.lsp.buf.type_definition()<CR>" },
    ["<space>d"] = { ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>" },

    ["<A-j>"] = { "<cmd>m .+1<CR>==", "Move current line down" },
    ["<A-k>"] = { "<cmd>m .-2<CR>==", "Move current line up" },

    -- quick fix
    ["<C-n>"] = { "<cmd>cnext<CR>", "Go to next item in quick fix list" },
    ["<C-p>"] = { "<cmd>cprev<CR>", "Go to previous item in quick fix list" },
    ["<C-q>"] = { "<cmd>call ToggleQuickFixList()<CR>", "Toggle quick fix list" },

   -- buffers
    ["<A-.>"] = { "<cmd>BufferNext<CR>", "Go to next tab" },
    ["<A-,>"] = { "<cmd>BufferPrevious<CR>", "Go to previous tab" },
    ["<A->>"] = { "<cmd>BufferMoveNext<CR>", "Move previous tab"  },
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
            b = { "<cmd>Telescope git_branches<CR>", "Show branches" },
            c = { "<cmd>Telescope git_commits<CR>", "Show commit log" },
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
            n = { "<cmd>enew<cr>", "New empty buffer" },
        },
        f = { "<cmd>FindFile<CR>", "Fuzzy find files" },
        s = {
            name = "Search",
            f = { "<cmd>Telescope filetypes<CR>", "Search and set buffer filetype" },
            m = { "<cmd>Telescope man_pages<CR>", "Search man pages" },
            o = { "<cmd>Telescope oldfiles<CR>", "Search for old files" },
            p = { "<cmd>Telescope projects<CR>", "Search for projects" },
            t = { "<cmd>Telescope live_grep<CR>", "Search for text" },
            s = { "<cmd>Telescope<CR>", "Search for Telescope things" },
        },
        l = {
            name = "LSP",
            f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },
            a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
            r = { "<cmd>lua vim.lsp.buf.rename()<CR>" },
            p = {
              name = "Peek",
              d = { "<cmd>lua require('lsp.peek').Peek('definition')<cr>", "Peek definition" },
              t = { "<cmd>lua require('lsp.peek').Peek('typeDefinition')<cr>", "Peek type Definition" },
              i = { "<cmd>lua require('lsp.peek').Peek('implementation')<cr>", "Peek implementation" },
            },
            q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Populate quick fix list with diagnostics" },
        },
        p = {
            name = "Packer (plugin manager)",
            s = { "<cmd>PackerSync<CR>", "Packer sync" },
            i = { "<cmd>PackerStatus<CR>", "Packer plugin info" },
        },
        d = {
            name = "Debugger",
            t = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle break point" },
            b = { "<cmd>lua require('dap').step_back()<cr>", "Step back" },
            c = { "<cmd>lua require('dap').continue()<cr>", "Continue/start debug" },
            C = { "<cmd>lua require('dap').run_to_cursor()<cr>", "Run until breakpoint" },
            d = { "<cmd>lua require('dap').disconnect()<cr>", "Disconnect" },
            g = { "<cmd>lua require('dap').session()<cr>", "Get session" },
            i = { "<cmd>lua require('dap').step_into()<cr>", "Step into" },
            o = { "<cmd>lua require('dap').step_over()<cr>", "Step over" },
            u = { "<cmd>lua require('dap').step_out()<cr>", "Step out" },
            p = { "<cmd>lua require('dap').pause.toggle()<cr>", "Toggle paused" },
            r = { "<cmd>lua require('dap').repl.toggle()<cr>", "Toggle repl" },
            q = { "<cmd>lua require('dap').close()<cr>", "Quit debugger" },
        },
    },
}, { silent = false })

DefineAugroup("general_settings", {
    "FileType c,cpp,javascript,javascriptreact,typescript,typescriptreact setlocal commentstring=//\\ %s",

    -- When editing a file, always jump to the last known cursor position.
    -- Don't do it when the position is invalid, when inside an event handler
    -- (happens when dropping a file on gvim) and for a commit message (it's
    -- likely a different one than last time).
    [[BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]],
})

vim.api.nvim_command [[
    function! ToggleQuickFixList()
        if empty(filter(getwininfo(), 'v:val.quickfix'))
            copen
        else
            cclose
        endif
    endfunction
]]
