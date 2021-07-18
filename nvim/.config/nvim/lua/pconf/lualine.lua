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
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local column = vim.fn.col(".")
    return string.format("%d/%d:%d", current_line, total_lines, column)
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_lsp" },
}

local diff = {
    "diff",
    color_added = colors.green,
    color_modified = colors.orange,
    color_removed = colors.red,
}

require("lualine").setup({
    options = {
        theme = "tokyonight",
        disabled_filetypes = { "NvimTree" },
        section_separators = { "", "" },
        component_separators = { "│", "│" },
    },
    sections = {
        lualine_b = { "branch", diff },
        lualine_c = { "filename", diagnostics },
        lualine_x = { "fileformat", "encoding" },
        lualine_y = { "filetype" },
        lualine_z = { get_wordcount, get_line, "progress" },
    }
})
