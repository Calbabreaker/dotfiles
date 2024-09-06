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

ls.add_snippets("typescriptreact", {
    s("fc", {
        t({
            "interface Props {",
            "    ",
        }),
        i(2),
        t({
            " ",
            "}",
            "",
            "",
        }),
        t("export const "),
        i(1, "<name>"),
        t(": React.FC<Props> = ({"),
        i(3),
        t({
            "}) => {",
            "   return ",
        }),
        i(0),
        t({
            "",
            "}",
        }),
    }),
})

ls.add_snippets("all", {
    s("cf-style", {
        t({
            "AlignAfterOpenBracket: BlockIndent",
            "AllowShortBlocksOnASingleLine: Empty",
            "AllowShortCaseLabelsOnASingleLine: false",
            "AllowShortFunctionsOnASingleLine: Empty",
            "AllowShortIfStatementsOnASingleLine: Never",
            "AllowShortLambdasOnASingleLine: All",
            "AllowShortLoopsOnASingleLine: false",
            "AlwaysBreakAfterReturnType: None",
            "ColumnLimit: 100",
            "IndentWidth: 4",
            "PointerAlignment: Left",
            "AccessModifierOffset: 0"
        }),
    }),
})

require("luasnip/loaders/from_vscode").lazy_load({
    paths = {
        DATA_PATH .. "/site/pack/packer/start/friendly-snippets",
    },
})
