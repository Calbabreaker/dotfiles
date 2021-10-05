local colors = require("onedark.colors")
local null_ls_config = require("null-ls.config")

local function get_wordcount()
	local wordcount = vim.fn.wordcount()
	local outwords = wordcount.words
	if wordcount.visual_words ~= nil then
		outwords = string.format("%d/%d", wordcount.visual_words, outwords)
	end

	return outwords .. " words"
end

local function get_cols()
	return string.format("%d/%d", vim.fn.col("."), vim.fn.col("$"))
end

local function lsp()
	local buffer_filetype = vim.bo.filetype
	local client_names = {}

	-- add lsp client
	for _, client in pairs(vim.lsp.buf_get_clients()) do
		if client.name ~= "null-ls" then
			table.insert(client_names, client.name)
		end
	end

	-- add null-ls linter and formatter clients
	for _, source in pairs(AvailiableSources) do
		if vim.tbl_contains(source.filetypes, buffer_filetype) then
			table.insert(client_names, source.name)
		end
	end

	local msg = "Inactive"
	if #client_names ~= 0 then
		msg = table.concat(client_names, ", ")
	end

	return "  " .. msg
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_lsp" },
}

local diff = {
	"diff",
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.yellow },
		removed = { fg = colors.red },
	},
}

require("lualine").setup({
	options = {
		theme = "onedark",
		disabled_filetypes = { "NvimTree", "packer" },
		section_separators = { left = "", right = "" },
		component_separators = { left = "│", right = "│" },
	},
	sections = {
		lualine_b = { "branch", diff },
		lualine_c = { "filename", diagnostics },
		lualine_x = { lsp },
		lualine_y = { "filetype" },
		lualine_z = { get_wordcount, get_cols, "progress" },
	},
})
