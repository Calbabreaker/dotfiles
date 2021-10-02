local colors = require("tokyonight.colors").setup()

local function get_wordcount()
    local wordcount = vim.fn.wordcount()
    local outwords = wordcount.words
    if wordcount.visual_words ~= nil then
        outwords = string.format("%d/%d", wordcount.visual_words, outwords)
    end

    return outwords.." words"
end

local function get_line()
    -- current_line/total_lines:current_col/total_cols
    return string.format("%d/%d:%d/%d",
        vim.fn.line("."), vim.fn.line("$"), vim.fn.col("."), vim.fn.col("$"))
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_lsp" },
}

local diff = {
    "diff",
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.yellow },
        removed = { fg = colors.red },
    },
}

require("lualine").setup({
    options = {
        theme = "tokyonight",
        disabled_filetypes = { "NvimTree" },
        section_separators = { left = "", right = "" },
        component_separators = { left = "│", right = "│" },
    },
    sections = {
        lualine_b = { "branch", diff },
        lualine_c = { "filename", diagnostics },
        lualine_x = { "fileformat", "encoding" },
        lualine_y = { "filetype" },
        lualine_z = { get_wordcount, get_line, "progress" },
    }
})
