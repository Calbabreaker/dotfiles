local null_ls = require("null-ls")

local sources = {
	null_ls.builtins.diagnostics.eslint_d,
	null_ls.builtins.diagnostics.write_good,
	null_ls.builtins.formatting.clang_format,
	null_ls.builtins.formatting.eslint_d,
	null_ls.builtins.formatting.prettierd,
	null_ls.builtins.formatting.stylua,
}

-- only have source if exe exists
AvailiableSources = {}
for _, source in pairs(sources) do
	if CheckExist(source.name) then
		table.insert(AvailiableSources, source)
	end
end

null_ls.config({
	sources = AvailiableSources,
})

require("lspconfig")["null-ls"].setup({})
