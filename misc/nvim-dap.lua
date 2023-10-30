local dap = require("dap")

dap.configurations.rust = {
    {
        name = "rust",
        type = "rt_lldb",
        request = "launch",
        program = "${workspaceFolder}/build/host/stage1/bin/rustc",
        cwd =  "${workspaceFolder}",
        stopOnEntry = false,
        args = {"-V"},
    },
}

-- vim.notify(vim.inspect(require("dap")))
