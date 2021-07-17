local lsp_installer = require("nvim-lsp-installer")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

local function on_attach(_, buffer)
    vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")

    register_mappings("n", { silent = true, noremap = true, buffer = buffer }, {
        { "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>" },
        { "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>" },
        { "K", "<Cmd>lua vim.lsp.buf.hover()<CR>" },
        { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
        { "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>" },
        { "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>" },
        { "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>" },
        { "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>" },
        { "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>" },
        { "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>" },
        { "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
        { "gl", "<cmd>lua vim.lsp.buf.references()<CR>" },
        { "<space>d", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>" },
        { "[g", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>" },
        { "]g", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>" },
        { "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>" },
        { "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>" },
    })
end

local installed_servers = lsp_installer.get_installed_servers()
for _, server in pairs(installed_servers) do
    server:setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

local ensured_installed_servers = { "tsserver", "html", "cssls", "jsonls" }

-- ensures specified servers are installed
-- aditional can be installed using :LspInstall server_name
for _, server_name in pairs(ensured_installed_servers) do
    local ok, server = lsp_installer.get_server(server_name)
    if ok and not server:is_installed() then
        server:install()
    end
end
