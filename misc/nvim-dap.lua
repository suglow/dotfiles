local dap = require("dap")

local extension_path = os.getenv("HOME") .. "/.local/bin/cpptools/extension/"
local opendebug_path = extension_path .. "debugAdapters/bin/OpenDebugAD7"

function Split(s, delimiter)
	local result = {}
	for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end
	return result
end

dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = opendebug_path,
  options = {
    detached = false
  }
}

dap.configurations.rust = {
	{
		name = "rust",
		type = "rt_lldb",
		request = "launch",
		program = "${workspaceFolder}/build/host/stage1/bin/rustc",
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = { "-V" },
	},
}

dap.configurations.c = {
	{
		name = "qemu-kernel-gdb",
		type = "cppdbg",
		request = "launch",
		miDebuggerServerAddress = "127.0.0.1:1234",
		program = "${workspaceFolder}/vmlinux",
		cwd = "${workspaceFolder}",
		stopAtEntry = false,
		args = {},
		environment = {},
		externalConsole = true,
		logging = {
			engingLogging = false,
		},
		MIMode = "gdb",
	},
}

dap.configurations.cpp  = {
  {
    name = "start gdb",
    type = "cppdbg",
    request = "launch",
    program = "${workspaceFolder}/build/bin/clang",
    args = {"-cc1", "-analyze", "-analyzer-checker=alpha.unix.SimpleStream", "/workspace/test/test.c"},
    stopAtEntry = false,
    cwd = "${workspaceFolder}",
    environment = {},
    externalConsole = false,
    MIMode = "gdb",
    setupCommands = {
      {
          description = "为 gdb 启用整齐打印",
          text = "-enable-pretty-printing",
          ignoreFailures = true
      },
      {
          description = "将反汇编风格设置为 Intel",
          text = "-gdb-set disassembly-flavor intel",
          ignoreFailures = true
      },
      {text = "-gdb-set follow-fork-mode child"},
      {text = "-gdb-set detach-on-fork off"}
    }
  },
  {
    name = "debug cpp",
    type = "codelldb",
    request = "launch",
    program = "${workspaceFolder}/build/bin/clang",
    args = {"-cc1", "-analyze", "-analyzer-checker=alpha.unix.SimpleStream", "/workspace/test/test.c"},
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
  }
}

-- vim.notify(vim.inspect(require("dap")))

