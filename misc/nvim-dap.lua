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

-- vim.notify(vim.inspect(require("dap")))
