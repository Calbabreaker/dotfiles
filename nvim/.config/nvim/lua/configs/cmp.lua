local function has_words_before()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function has_space_before()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local completion_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "ﰠ",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "塞",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "פּ",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

-- highlights for cmp kind symbols
vim.cmd([[
    highlight! link CmpItemKindText  Comment
    highlight! link CmpItemKindMethod  TSMethod
    highlight! link CmpItemKindFunction  Function
    highlight! link CmpItemKindConstructor  TSConstructor
    highlight! link CmpItemKindField  TSField
    highlight! link CmpItemKindVariable  TSVariable
    highlight! link CmpItemKindClass  Class
    highlight! link CmpItemKindInterface  Constant
    highlight! link CmpItemKindModule  Include
    highlight! link CmpItemKindProperty  TSProperty
    highlight! link CmpItemKindUnit  Constant
    highlight! link CmpItemKindValue  TSVariable
    highlight! link CmpItemKindEnum  Type
    highlight! link CmpItemKindKeyword  TSKeyword
    highlight! link CmpItemKindFile  Directory
    highlight! link CmpItemKindReference  Question
    highlight! link CmpItemKindConstant  Constant
    highlight! link CmpItemKindStruct  Type
    highlight! link CmpItemKindEvent  TSVariable
    highlight! link CmpItemKindOperator  Operator
    highlight! link CmpItemKindTypeParameter  Type
    highlight! link CmpItemKindSnippet  Statement
]])

local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
		["<Tab>"] = cmp.mapping(function(fallback)
			local luasnip = require("luasnip")
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() and not has_space_before() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, {
			"i",
			"s",
		}),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			local luasnip = require("luasnip")
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	documentation = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = completion_icons[vim_item.kind]
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				path = "[Path]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
			})[entry.source.name]
			return vim_item
		end,
	},
	experimental = {
		ghost_text = true,
	},
})
