local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}

local function on_attach(client)
	-- turn off formatting for lsp if if null-ls already has one availiable
	if NullLSGetAvail(vim.bo.filetype) ~= nil then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end
end

-- add aditional servers here that isn't in the installer or already installed (will only enable if exist)
-- note that it will prefer ones with :LspInstall
local aditional_servers = {
	clangd = {},
	gdscript = {},
}

lsp_installer.on_server_ready(function(server)
	aditional_servers[server.name] = nil
	server:setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
	vim.cmd("do User LspAttachBuffers")
end)

for name, config in pairs(aditional_servers) do
	local cmd = config.cmd or lspconfig[name].document_config.default_config.cmd
	if vim.fn.executable(cmd[1]) == 1 then
		config.capabilities = capabilities
		config.on_attach = on_attach
		lspconfig[name].setup(config)
	end
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end