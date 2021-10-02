local dap = require("dap")

-- c/c++/rust
dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode",
    name = "lldb"
}

local ccrust_config = {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
    args = {},
    runInTerminal = false,
}

dap.configurations.cpp = { ccrust_config }
dap.configurations.c = { ccrust_config }
dap.configurations.rust = { ccrust_config }

vim.fn.sign_define("DapBreakpoint", {
    text = "",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
    text = "",
    texthl = "LspDiagnosticsSignWarning",
    linehl = "",
    numhl = "",
})

vim.fn.sign_define("DapStopped", {
    text = "",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation",
})

RegisterMappings("n", {}, {
    { "<Leader>dt", "<cmd>lua require('dap').toggle_breakpoint()<cr>" },
    { "<Leader>db", "<cmd>lua require('dap').step_back()<cr>" },
    { "<Leader>dc", "<cmd>lua require('dap').continue()<cr>" },
    { "<Leader>dC", "<cmd>lua require('dap').run_to_cursor()<cr>" },
    { "<Leader>dd", "<cmd>lua require('dap').disconnect()<cr>" },
    { "<Leader>dg", "<cmd>lua require('dap').session()<cr>" },
    { "<Leader>di", "<cmd>lua require('dap').step_into()<cr>" },
    { "<Leader>do", "<cmd>lua require('dap').step_over()<cr>" },
    { "<Leader>du", "<cmd>lua require('dap').step_out()<cr>" },
    { "<Leader>dp", "<cmd>lua require('dap').pause.toggle()<cr>" },
    { "<Leader>dr", "<cmd>lua require('dap').repl.toggle()<cr>" },
    { "<Leader>dq", "<cmd>lua require('dap').close()<cr>" },
})
