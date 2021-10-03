-- mode takes in a character or multiple specifying the mode
-- note this means that ic mode will not work
function RegisterMappings(mode, options, mappings)
    -- split up the string
    if #mode > 1 then
        for i = 1, #mode do
            RegisterMappings(mode:sub(i, i), options, mappings)
        end
        return
    end

    for _, mapping in pairs(mappings) do
        local key = mapping[1]
        local cmd = mapping[2]
        -- add terminal escape
        if mode == "t" then
            cmd = "<C-\\><C-N>"..cmd
        end

        -- convert " " to "" (normal, operater pending, etc... mapping)
        if mode == " " then mode = "" end

        if options.buffer ~= nil then
            local buffer = options.buffer
            options.buffer = nil
            vim.api.nvim_buf_set_keymap(buffer, mode, key, cmd, options)
        else
            vim.api.nvim_set_keymap(mode, key, cmd, options)
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

RegisterMappings(" ic", { silent = true }, {
    { "<C-c>", "<ESC>" },
    { "<ESC>", "<ESC>:noh <CR>" }, -- use esc to hide highlights
})

RegisterMappings(" ti", { silent = true }, {
    -- make window navigation easier
    { "<C-h>", "<ESC><C-w>h" },
    { "<C-j>", "<ESC><C-w>j" },
    { "<C-k>", "<ESC><C-w>k" },
    { "<C-l>", "<ESC><C-w>l" },

    -- resize using arrow keys
    { "<C-Left>", "<ESC>:vertical resize +3<CR>" },
    { "<C-Right>", "<ESC>:vertical resize -3<CR>" },
    { "<C-Up>", "<ESC>:resize +3<CR>" },
    { "<C-Down>", "<ESC>:resize -3<CR>" },
})

RegisterMappings("n", { silent = true }, {
    { "<C-s>", ":w<CR>"},
    { "<C-S>", ":noa w<CR>"},

    -- move line up and down
    { "<A-j>", ":m .+1<CR>==" },
    { "<A-k>", ":m .-2<CR>==" },

    -- quick fix
    { "<C-n>", ":cnext<CR>" },
    { "<C-p>", ":cprev<CR>" },
    { "<C-q>", ":call ToggleQuickFixList()<CR>" },

    -- fugitive
    { "<Leader>gg", ":Git<CR>" },
    { "<Leader>gp", ":Git push<CR>" },
    { "<Leader>gh", ":diffget //2<CR>" },
    { "<Leader>gl", ":diffget //3<CR>" },

    -- terminal opening bindings
    { "<Leader>tt", ":ToggleTerm size=25 directory=horizontal<CR>"},
    { "<Leader>tw", ":ToggleTerm direction=window<CR>"},
    { "<Leader>tf", ":ToggleTerm direction=float<CR>"},
    { "<Leader>to", ":ToggleTermOpenAll"},

    -- change from vertical to horizontal split and vise versa
    { "<Leader>th", "<C-w>t<C-w>K" },
    { "<Leader>tv", "<C-w>t<C-w>H" },
})

DefineAugroup("general_settings", {
    "FileType c,cpp,javascript,javascriptreact,typescript,typescriptreact setlocal commentstring=//\\ %s",

    -- When editing a file, always jump to the last known cursor position.
    -- Don't do it when the position is invalid, when inside an event handler
    -- (happens when dropping a file on gvim) and for a commit message (it's
    -- likely a different one than last time).
    [[BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]],
})

vim.cmd [[
    function! ToggleQuickFixList()
        if empty(filter(getwininfo(), 'v:val.quickfix'))
            copen
        else
            cclose
        endif
    endfunction
]]
