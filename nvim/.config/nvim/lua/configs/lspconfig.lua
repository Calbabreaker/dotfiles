local lsp_status = require("lsp-status")
lsp_status.register_progress()

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

capabilities.window = { workDoneProgress = true }

local function on_attach(client)
	-- turn off formatting for lsp if if null-ls already has one availiable
	if NullLSGetAvail(vim.bo.filetype) ~= nil then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end
end

-- servers installed using lsp-installer will use this
-- if that server is installed it will try to setup it if it exists
local server_configs = {
	clangd = {},
	gdscript = {},
	sumneko_lua = {
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
}

lsp_installer.on_server_ready(function(server)
	local config = server_configs[server.name] or {}
	server_configs[server.name] = nil

	config.capabilities = capabilities
	config.on_attach = on_attach

	server:setup(config)
	vim.api.nvim_command("do User LspAttachBuffers")
end)

for name, config in pairs(server_configs) do
	local cmd = config.cmd or lspconfig[name].document_config.default_config.cmd
	if cmd and vim.fn.executable(cmd[1]) == 1 then
		config.capabilities = capabilities
		config.on_attach = on_attach
		lspconfig[name].setup(config)
	end
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
