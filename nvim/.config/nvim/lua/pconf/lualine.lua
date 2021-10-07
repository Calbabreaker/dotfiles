local colors = require("onedark.colors")

local function get_wordcount()
	local wordcount = vim.fn.wordcount()
	local outwords = wordcount.words
	if wordcount.visual_words ~= nil then
		outwords = string.format("%d/%d", wordcount.visual_words, outwords)
	end

	return outwords .. " words"
end

local function get_ruler()
	return string.format("%d:%d", vim.fn.line("."), vim.fn.col("."))
end

local function clients()
	local client_names = {}

	-- add lsp client
	for _, client in pairs(vim.lsp.buf_get_clients()) do
		if client.name ~= "null-ls" then
			table.insert(client_names, client.name)
		end
	end

	-- add null-ls linter and formatter clients
	if NullLSGetAvail ~= nil then
		vim.list_extend(client_names, NullLSGetAvail(vim.bo.filetype) or {})
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
		disabled_filetypes = { "NvimTree", "packer", "dashboard" },
		section_separators = { left = "", right = "" },
		component_separators = { left = "│", right = "│" },
	},
	sections = {
		lualine_b = { "branch", diff },
		lualine_c = { "filename", diagnostics },
		lualine_x = { clients },
		lualine_y = { "filetype" },
		lualine_z = { get_wordcount, get_ruler, "progress" },
	},
})
