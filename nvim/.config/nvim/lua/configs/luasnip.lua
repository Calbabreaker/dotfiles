local ls = require("luasnip")
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

local c_hello_world = s({ trig = "hello", dscr = "Basic hello world" }, {
	t({
		"#include <stdio.h>",
		"",
		"int main(int argc, char** argv)",
		"{",
		'    printf("Hello, World!\\n");',
	}),
	i(0),
	t({
		"",
		"    return 0;",
		"}",
	}),
})

ls.add_snippets("c", { c_hello_world })
ls.add_snippets("cpp", { c_hello_world })

ls.add_snippets("rust", {
	s("println-dbg", {
		t('println!("{:?}", '),
		i(0, "<var>"),
		t(");"),
	}),
})

ls.add_snippets("cmake", {
	s("starter", {
		t({
			"cmake_minimum_required(VERSION 3.12 FATAL_ERROR)",
			"project(",
		}),
		i(1, "<name>"),
		t({
			")",
			"",
			'if(NOT EXISTS "${CMAKE_BINARY_DIR}/yacpm.cmake")',
			'    file(DOWNLOAD "https://github.com/Calbabreaker/yacpm/raw/v3/yacpm.cmake" "${CMAKE_BINARY_DIR}/yacpm.cmake")',
			"endif()",
			"",
			"include(${CMAKE_BINARY_DIR}/yacpm.cmake)",
			"yacpm_use_extended()",
			"",
			"add_executable(${PROJECT_NAME}",
			"    main.cpp",
		}),
		i(0),
		t({
			")",
			"yacpm_target_warnings(${PROJECT_NAME})",
			"",
			"target_link_libraries(${PROJECT_NAME} ${YACPM_PACKAGES})",
		}),
	}),
})

ls.add_snippets("all", {
	s("cf-style", {
		t({
			"AccessModifierOffset: -4",
			"AllowShortFunctionsOnASingleLine: InlineOnly",
			"AllowShortLambdasOnASingleLine: Empty",
			"AlwaysBreakTemplateDeclarations: Yes",
			"BreakBeforeBraces: Allman",
			"ColumnLimit: 100",
			"FixNamespaceComments: true",
			"IndentPPDirectives: BeforeHash ",
			"IndentWidth: 4",
			"LambdaBodyIndentation: OuterScope",
			"PointerAlignment: Left",
			"",
			"PenaltyReturnTypeOnItsOwnLine: 999999",
			"",
			"BreakBeforeBraces: Custom",
			"BraceWrapping:",
			"    AfterNamespace: false ",
			"    AfterControlStatement: true",
			"    AfterEnum: true",
			"    AfterClass: true",
			"    AfterStruct: true",
			"    AfterUnion: true",
			"    BeforeCatch: true",
			"    BeforeElse: true",
			"    AfterFunction: true",
			"    AfterCaseLabel: true",
		}),
	}),
	s("mit", {
		t({
			"MIT License",
			"",
			"Copyright (c) ",
		}),
		f(function(_, _)
			return os.date("%Y ")
		end, {}),
		i(1, "<copyright holders>"),
		t({
			"",
			"",
			"Permission is hereby granted, free of charge, to any person obtaining a copy",
			'of this software and associated documentation files (the "Software"), to deal',
			"in the Software without restriction, including without limitation the rights",
			"to use, copy, modify, merge, publish, distribute, sublicense, and/or sell",
			"copies of the Software, and to permit persons to whom the Software is",
			"furnished to do so, subject to the following conditions:",
			"",
			"The above copyright notice and this permission notice shall be included in all",
			"copies or substantial portions of the Software.",
			"",
			'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR',
			"IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,",
			"FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE",
			"AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER",
			"LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,",
			"OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE",
			"SOFTWARE.",
		}),
	}),
	s(
		"lorem-ipsum",
		t(
			"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
		)
	),
	s(
		"date",
		f(function(_, _)
			return os.date("%d/%m/%Y")
		end, {})
	),
})

require("luasnip/loaders/from_vscode").lazy_load({
	paths = {
		DATA_PATH .. "/site/pack/packer/start/friendly-snippets",
	},
})
