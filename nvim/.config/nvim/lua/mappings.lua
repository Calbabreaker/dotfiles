-- mode takes in a character or multiple specifying the mode
-- note this means that ic mode will not work
function register_mappings(mode, default_options, mappings)
    -- split up the string
    if #mode > 1 then
    	for i = 1, #mode do
            register_mappings(mode:sub(i, i), default_options, mappings)
    	end
        return
    end

    for _, mapping in pairs(mappings) do
        local options = mapping[3] or default_options
        local key = mapping[1]
        local cmd = mapping[2]
        -- add terminal escape
        if mode == "t" then
            cmd = "<C-\\><C-N>"..cmd
        end

        -- convert " " to "" (normal, operater pending, etc... mapping)
        if mode == " " then mode = "" end

        if options.buffer ~= nil then
            options.buffer = nil
            vim.api.nvim_buf_set_keymap(default_options.buffer, mode, key, cmd, options)
        else
            vim.api.nvim_set_keymap(mode, key, cmd, options)
        end
    end
end

function define_augroup(name, definitions)
    vim.api.nvim_command("augroup "..name)
    vim.api.nvim_command "autocmd!"

    for _, definition in pairs(definitions) do
        vim.api.nvim_command("autocmd "..definition)
    end

    vim.api.nvim_command "augroup end"
end

register_mappings(" ic", { silent = true }, {
    { "<C-c>", "<ESC>" },
    { "<ESC>", "<ESC>:noh <CR>" }, -- use esc to hide highlights
})

register_mappings("tn", { silent = true }, {
    -- make window navigation easier
    { "<C-h>", "<C-w>h" },
    { "<C-j>", "<C-w>j" },
    { "<C-k>", "<C-w>k" },
    { "<C-l>", "<C-w>l" },

    -- resize using arrow keys
    { "<C-Left>", ":vertical resize +3<CR>" },
    { "<C-Right>", ":vertical resize -3<CR>" },
    { "<C-Up>", ":resize +3<CR>" },
    { "<C-Down>", ":resize -3<CR>" },

})

register_mappings("t", { silent = true }, {
    { "<ESC>", "" },
})

register_mappings("n", {}, {
    { "<C-s>", "<cmd>w<CR>"},
    { "<C-S>", "<cmd>noa w<CR>"},

    -- move line up and down
    { "<A-j>", ":m .+1<CR>==" },
    { "<A-k>", ":m .-2<CR>==" },

    -- quick fix
    { "<C-.>", ":cnext<CR>" },
    { "<C-,>", ":cprev<CR>" },
    { "<C-q>", ":call ToggleQuickFix()<CR>" },

    -- fugitive
    { "<Leader>gg", ":Git<CR>" },
    { "<Leader>gc", ":Git commit<CR>" },
    { "<Leader>gp", ":Git push<CR>" },
    { "<Leader>gh", ":diffget //2<CR>" },
    { "<Leader>gl", ":diffget //3<CR>" },

    { "<Leader>n", "<cmd>NvimTreeToggle<CR>"},

    -- change from vertical to horizontal split and vise versa
    { "<Leader>th", "<C-w>t<C-w>K" },
    { "<Leader>tv", "<C-w>t<C-w>H" },

    { "<Leader>tt", "<cmd>split<CR> <cmd>term<CR>"},
})

define_augroup("general_settings", {
    -- make terminal better
    "TermOpen term://* setlocal nonumber norelativenumber",
    "TermOpen term://* startinsert",
    "BufEnter term://* startinsert",

    -- When editing a file, always jump to the last known cursor position.
    -- Don't do it when the position is invalid, when inside an event handler
    -- (happens when dropping a file on gvim) and for a commit message (it's
    -- likely a different one than last time).
    [[BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]],
})

vim.cmd [[
    function! ToggleQuickFix()
        if empty(filter(getwininfo(), 'v:val.quickfix'))
            copen
        else
            cclose
        endif
    endfunction
]]
