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
