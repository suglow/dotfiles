
local extension_path = "/home/suglow/.local/bin/codelldb/extension/" 
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

return {
  adapters = require('rust-tools.dap').get_codelldb_adapter(
          codelldb_path, liblldb_path),
  configurations = {
    {
      name = 'Launch',
      type = 'codelldb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
    }
  }
}
