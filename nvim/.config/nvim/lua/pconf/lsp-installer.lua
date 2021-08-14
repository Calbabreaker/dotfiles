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

local function on_attach(_, buffer)
    vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")

    RegisterMappings("n", { silent = true, noremap = true, buffer = buffer }, {
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

-- add aditional servers here that isn't in the installer or already installed
-- note that it will prefer ones with :LspInstall
local aditional_servers = {
    gdscript = {},
    clangd = {},
    tsserver = {},
    svelte = {},
    jsonls = {},
    html = {},
    cssls = {},
}

local installed_servers = lsp_installer.get_installed_servers()
for _, server in pairs(installed_servers) do
    aditional_servers[server] = nil
    server:setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

for name, config in pairs(aditional_servers) do
    config.on_attach = on_attach
    config.capabilities = capabilities
    lspconfig[name].setup(config)
end

