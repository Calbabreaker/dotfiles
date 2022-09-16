local null_ls = require("null-ls")
local sources = {
	null_ls.builtins.diagnostics.eslint_d,
	null_ls.builtins.formatting.eslint_d,
	null_ls.builtins.formatting.prettierd.with({
		env = {
			PRETTIERD_DEFAULT_CONFIG = CONFIG_PATH .. "/lua/configs/.prettierrc.json",
		},
	}),
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.hover.dictionary,
}

local filetype_to_sources = {}

-- only have source if exe exists
local availiable_sources = {}
for _, source in pairs(sources) do
	local cmd = source._opts.command
	if not cmd or vim.fn.executable(cmd) == 1 then
		table.insert(availiable_sources, source)

		-- create filetype_to_source table for faster NullLSGetAvail lookup
		for _, filetype in pairs(source.filetypes) do
			if filetype_to_sources[filetype] == nil then
				filetype_to_sources[filetype] = {}
			end

			local source_names = filetype_to_sources[filetype]
			if not vim.tbl_contains(source_names) then
				table.insert(source_names, source.name)
			end
		end
	end
end

function NullLSGetAvail(filetype)
	return filetype_to_sources[filetype]
end

null_ls.setup({
	sources = availiable_sources,
})
