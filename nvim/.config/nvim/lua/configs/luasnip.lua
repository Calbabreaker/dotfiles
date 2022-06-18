local ls = require("luasnip")
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

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
})

require("luasnip/loaders/from_vscode").lazy_load({
	paths = {
		DATA_PATH .. "/site/pack/packer/start/friendly-snippets",
	},
})
