local lsp_status = require("lsp-status")
lsp_status.register_progress()

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

local function on_attach(client)
	-- turn off formatting for lsp if if null-ls already has one availiable
	if NullLSGetAvail(vim.bo.filetype) ~= nil then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end

	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
			false
		)
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

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local config = server_configs[server.name] or {}
	server_configs[server.name] = nil

	config.capabilities = capabilities
	config.on_attach = on_attach

	server:setup(config)
	vim.api.nvim_command("do User LspAttachBuffers")
end)

local lspconfig = require("lspconfig")
for name, config in pairs(server_configs) do
	local cmd = config.cmd or lspconfig[name].document_config.default_config.cmd
	if cmd and vim.fn.executable(cmd[1]) == 1 then
		config.capabilities = capabilities
		config.on_attach = on_attach
		lspconfig[name].setup(config)
	end
end

-- other configurations
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

-- dumb hack to fix rust_analyzer content modified message thing being annyoing
local notify = vim.notify
vim.notify = function(msg, ...)
    if not msg:match("content modified") then 
        notify(msg, ...)
    end
end
