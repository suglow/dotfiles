local extension_path = os.getenv( "HOME" ) .. "/.local/bin/cpptools/extension/"
local opendebug_path = extension_path .. 'debugAdapters/bin/OpenDebugAD7'

return {
  adapters =  {
    id = 'cppdbg',
    type = 'executable',
    command = opendebug_path,
  },
  configurations = {
    {
      name = "Launch file",
      type = "cppdbg",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = true,
    },
    {
      name = 'Attach to gdbserver :1234',
      type = 'cppdbg',
      request = 'launch',
      MIMode = 'gdb',
      miDebuggerServerAddress = 'localhost:1234',
      miDebuggerPath = '/usr/bin/gdb',
      cwd = '${workspaceFolder}',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
    },
  }
}
