local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local cxx_hello_world = s({ trig = "hello", dscr = "Basic hello world" }, {
	t({
		"#include <stdio.h>",
		"",
		"int main(int argc, char *argv[])",
		"{",
		'    printf("Hello, World!");',
	}),
	i(0),
	t({
		"",
		"    return 0;",
		"}",
	}),
})

ls.snippets = {
	c = { cxx_hello_world },
	cpp = { cxx_hello_world },
}

require("luasnip/loaders/from_vscode").lazy_load({
	paths = {
		DATA_PATH .. "/site/pack/packer/opt/friendly-snippets",
	},
})
