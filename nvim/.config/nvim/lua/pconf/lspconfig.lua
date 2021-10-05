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

-- add aditional servers here that isn't in the installer or already installed (will only enable if exist)
-- note that it will prefer ones with :LspInstall
local aditional_servers = {
	clangd = {},
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
	local cmd = config.cmd or lspconfig[name].document_config.default_config.cmd
	if CheckExist(cmd[1]) then
		config.capabilities = capabilities
		lspconfig[name].setup(config)
	end
end

vim.fn.sign_define("LspDiagnosticsSignError", { text = " ", texthl = "LspDiagnosticsSignError", numhl = "" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = " ", texthl = "LspDiagnosticsSignWarning", numhl = "" })
vim.fn.sign_define("LspDiagnosticsSignHint", { text = " ", texthl = "LspDiagnosticsSignHint", numhl = "" })
vim.fn.sign_define(
	"LspDiagnosticsSignInformation",
	{ text = " ", texthl = "LspDiagnosticsSignInformation", numhl = "" }
)