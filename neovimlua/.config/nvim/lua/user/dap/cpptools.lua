local extension_path = os.getenv( "HOME" ) .. "/.local/bin/cpptools/extension/"
local opendebug_path = extension_path .. 'debugAdapters/bin/OpenDebugAD7'

function Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end


return {
  adapters =  {
    id = 'cppdbg',
    type = 'executable',
    command = opendebug_path,
    enrich_config = function(config, on_config)
      local final_config = vim.deepcopy(config)
      -- final_config.extra_property = 'This got injected by the adapter'
      local command = vim.fn.input('command: ', '')
      local arguments = Split(command, ' +')
      local program = ''
      local args = {}
      if #arguments == 1 then
        program = arguments[0]
        args = {}
      end
      if #arguments > 1 then
        program = arguments[1]
        table.remove(arguments,1)
        args = arguments
      end
      -- print(program)
      -- print(vim.inspect(args))
      final_config.args = args
      final_config.program = program
      on_config(final_config)
    end;
  },
  configurations = {
    {
      name = "Launch command",
      type = "cppdbg",
      request = "launch",
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
      -- program = function()
      --   return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      -- end,
    },
    -- {
    --   name = "Launch bin",
    --   type = "cppdbg",
    --   request = "launch",
    --   program = function()
    --     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --   end,
    --   cwd = '${workspaceFolder}',
    --   stopOnEntry = true,
    --   args = function()
    --     local argstring = vim.fn.input('args', '')
    --     return Split(argstring, ' ')
    --   end
    -- }
  }
}
