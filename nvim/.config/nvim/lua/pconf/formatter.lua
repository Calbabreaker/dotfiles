local prettier = {
    function()
        -- check if there is a local prettier exe or use the global one
        local prettier_exe = "./node_modules/.bin/prettier"
        if vim.fn.executable(prettier_exe) ~= 1 then
            prettier_exe = "prettier"
        end

        return {
            exe = prettier_exe,
            args = {
                "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                "--config-precedence", "file-override",
                "--tab-width", "4",
                "--print-width", "100",
            },
            stdin = true,
        }
    end
}

local clangformat = {
    function()
        return {
            exe = "clang-format",
            args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
            stdin = true,
            cwd = vim.fn.expand('%:p:h'),
        }
    end
}

require("formatter").setup({
    filetype = {
        c = clangformat,
        cpp = clangformat,

        css = prettier,
        html = prettier,
        javascript = prettier,
        javascriptreact = prettier,
        json = prettier,
        markdown = prettier,
        typescript = prettier,
        typescriptreact = prettier,
        svelte = prettier,
    }
})

RegisterMappings("ni", {}, {
    { "<C-f>", ":Format<CR>" }
});

DefineAugroup("format", {
    "BufWritePost * silent! FormatWrite"
})

