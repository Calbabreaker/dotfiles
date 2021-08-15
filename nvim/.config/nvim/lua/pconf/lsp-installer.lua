local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

-- add aditional servers here that isn't in the installer or already installed
-- note that it will prefer ones with :LspInstall
local aditional_servers = {
    clangd = {},
    cssls = {},
    gdscript = {},
    html = {},
    jsonls = {},
    svelte = {},
    tsserver = {},
}

local installed_servers = lsp_installer.get_installed_servers()
for _, server in pairs(installed_servers) do
    aditional_servers[server.name] = nil
    server:setup({
        capabilities,
    })
end

for name, config in pairs(aditional_servers) do
    config.capabilities = capabilities
    lspconfig[name].setup(config)
end

RegisterMappings("n", { silent = true, noremap = true }, {
    { "gD", ":lua vim.lsp.buf.declaration()<CR>" },
    { "gd", ":lua vim.lsp.buf.definition()<CR>" },
    { "K", ":lua vim.lsp.buf.hover()<CR>" },
    { "gi", ":lua vim.lsp.buf.implementation()<CR>" },
    { "<C-k>", ":lua vim.lsp.buf.signature_help()<CR>" },
    { "<space>wa", ":lua vim.lsp.buf.add_workspace_folder()<CR>" },
    { "<space>wr", ":lua vim.lsp.buf.remove_workspace_folder()<CR>" },
    { "<space>wl", ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>" },
    { "<space>D", ":lua vim.lsp.buf.type_definition()<CR>" },
    { "<space>rn", ":lua vim.lsp.buf.rename()<CR>" },
    { "<space>ca", ":lua vim.lsp.buf.code_action()<CR>" },
    { "gl", ":lua vim.lsp.buf.references()<CR>" },
    { "<space>d", ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>" },
    { "[g", ":lua vim.lsp.diagnostic.goto_prev()<CR>" },
    { "]g", ":lua vim.lsp.diagnostic.goto_next()<CR>" },
    { "<space>f", ":lua vim.lsp.buf.formatting()<CR>" },
})
