local prettier_formatter = {
    function()
        -- check if there is a local prettier exe or use the global one
        local prettier_exe = "./node_modules/.bin/prettier"
        if vim.fn.executable(prettier_exe) ~= 1 then
            prettier_exe = "prettier"
        end

        return {
            exe = prettier_exe,
            args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
            stdin = true
        }
    end
}

require("formatter").setup({
    filetype = {
        javascript = prettier_formatter,
        javascriptreact = prettier_formatter,
        typescript = prettier_formatter,
        typescriptreact = prettier_formatter,
        html = prettier_formatter,
        css = prettier_formatter,
        json = prettier_formatter,
    }
})

define_augroup("format", {
    "BufWrite * FormatWrite"
})
