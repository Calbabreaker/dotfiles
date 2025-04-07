local capabilities = vim.lsp.protocol.make_client_capabilities()
local completionItem = capabilities.textDocument.completion.completionItem
capabilities.window = { workDoneProgress = true }
completionItem.snippetSupport = true
completionItem.preselectSupport = true
completionItem.insertReplaceSupport = true
completionItem.labelDetailsSupport = true
completionItem.deprecatedSupport = true
completionItem.commitCharactersSupport = true
completionItem.tagSupport = { valueSet = { 1 } }
completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
    },
}

local function on_attach(client, bufnr)
    -- Turn off formatting for lsp if if null-ls already has one available
    if require("configs/null-ls").get_avail_sources(vim.bo.filetype) ~= nil then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end

    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec2(
            [[
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            {}
        )
    end
end

-- A list of servers with configs to be setup
-- Any servers installed by lsp-installer will be added onto this table
local server_configs = {
    dartls = {},
    clangd = {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
    },
    gdscript = {},
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim" },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
            },
        },
    },
    jsonls = {
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
            },
        },
    },
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                assist = {
                    importEnforceGranularity = true,
                    importPrefix = "crate",
                },
                cargo = {
                    allFeatures = true,
                },
                checkOnSave = {
                    command = "clippy",
                },
            },
        }
    }
}

require("mason").setup()
local mason_lsp = require("mason-lspconfig")
mason_lsp.setup()
for _, server in ipairs(mason_lsp.get_installed_servers()) do
    -- Add mason managed servers to the list
    server_configs[server] = server_configs[server] or {}
end

local lspconfig = require("lspconfig")
for name, config in pairs(server_configs) do
    -- Only setup server if it exists
    local cmd = lspconfig[name].document_config.default_config.cmd
    if type(cmd) ~= "table" or vim.fn.executable(cmd[1]) == 1 then
        config.capabilities = capabilities
        config.on_attach = on_attach
        lspconfig[name].setup(config)
    end
end

-- other configurations
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰌵 ",
            [vim.diagnostic.severity.INFO] = " "
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo"
        }

    },
    virtual_text = true,
})

vim.diagnostic.config({
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})
