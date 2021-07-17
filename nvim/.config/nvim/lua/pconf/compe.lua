local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function check_back_space()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet"s placeholder
function _G.tab_complete()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif vim.fn["vsnip#available"](1) == 1 then
        return t "<Plug>(vsnip-expand-or-jump)"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end

function _G.s_tab_complete()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        -- If <S-Tab> is not working in your terminal, change it to <C-h>
        return t "<S-Tab>"
    end
end

register_mappings("is", { expr = true }, {
    { "<Tab>", "v:lua.tab_complete()" },
    { "<S-Tab>", "v:lua.s_tab_complete()" },
})

register_mappings("i", { noremap = true, silent = true, expr = true }, {
    { "<C-Space>", "compe#complete()" },
    { "<CR>", "compe#confirm('<CR>')" },
    { "<C-e>", "compe#close('<C-e>')" },
    { "<C-f>", "compe#scroll({ 'delta': +4 })" },
    { "<C-d>", "compe#scroll({ 'delta': -4 })" },
})

require("compe").setup({
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,

    source = {
        path = { kind = "  " },
        buffer = { kind = "  " },
        calc = { kind = "  " },
        vsnip = { kind = "  " },
        tags = { kind = "  " },
        emoji = true,
        nvim_lsp = true,
        treesitter = false,
        nvim_lua = false,
        ultisnips = false,
        luasnip = false,
        snippets_nvim = false,
    },
})

-- icons for completion
vim.lsp.protocol.CompletionItemKind = {
  "   (Text) ",
  "   (Method)",
  "   (Function)",
  "   (Constructor)",
  " ﴲ  (Field)",
  "   (Variable)",
  "   (Class)",
  " ﰮ  (Interface)",
  "   (Module)",
  " 襁 (Property)",
  "   (Unit)",
  "   (Value)",
  " 練 (Enum)",
  "   (Keyword)",
  "   (Snippet)",
  "   (Color)",
  "   (File)",
  "   (Reference)",
  "   (Folder)",
  "   (EnumMember)",
  " ﲀ  (Constant)",
  " ﳤ  (Struct)",
  "   (Event)",
  "   (Operator)",
  "   (Type)",
}
