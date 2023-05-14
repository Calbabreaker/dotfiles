local completion_icons = {
    Text = "󰉿 ",
    Method = " ",
    Function = " ",
	Constructor = "",
    Field = "󰜢 ",
    Variable = "󰆦",
    Class = "󰠱 ",
    Interface = " ",
    Module = " ",
    Property = "󰜢 ",
    Unit = "󰑭 ",
    Value = "󰎠 ",
    Enum = " ",
    Keyword = "󰌋 ",
	Snippet = " ",
    Color = "󰏘 ",
    File = "󰈙 ",
    Reference = "󰈇 ",
    Folder = "󰉋 ",
    EnumMember = " ",
    Constant = "󰏿 ",
    Struct = "󰙅 ",
    Event = " ",
    Operator = "󰆕 ",
	TypeParameter = "",
}


local cmp = require("cmp")

local function visible_then_select(choose_next, fallback)
	if cmp.visible() then
		if choose_next then
			cmp.select_next_item()
		else
			cmp.select_prev_item()
		end
	else
		fallback() -- The fallback function sends a already mapped key.
	end
end

cmp.setup({
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<A-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			visible_then_select(true, fallback)
		end),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			visible_then_select(false, fallback)
		end),
		["<C-j>"] = cmp.mapping(function(fallback)
			visible_then_select(true, fallback)
		end),
		["<C-k>"] = cmp.mapping(function(fallback)
			visible_then_select(false, fallback)
		end),
		["<C-n>"] = cmp.mapping(function(fallback)
			local luasnip = require("luasnip")
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end),
		["<C-p>"] = cmp.mapping(function(fallback)
			local luasnip = require("luasnip")
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end),
	},
	window = {
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
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
				luasnip = "[Snippet]",
				nvim_lsp = "[LSP]",
				path = "[Path]",
				buffer = "[Buffer]",
			})[entry.source.name]
			return vim_item
		end,
	},
	experimental = {
		ghost_text = true,
	},
})
