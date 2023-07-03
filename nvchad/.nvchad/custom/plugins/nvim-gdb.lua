return {
  {
    "sakhnik/nvim-gdb",
    build = ":!./install.sh",
    init = function()
      vim.g.nvimgdb_disable_start_keymaps = true
      vim.g.nvimgdb_termwin_command = "belowright vnew"
      vim.g.nvimgdb_codewin_command = "vnew"
      vim.g.nvimgdb_use_find_executables = false
      vim.g.nvimgdb_use_cmake_to_find_executables = false

      vim.g.nvimgdb_config_override = {
        key_next = "<f10>",
        key_step = "<f11>",
        key_finish = "<f2>",
        key_continue = "<f5>",
        key_until = "<f6>",
        key_breakpoint = "<f9>",
      }
    end,
    keys = {
      { "\\dd", ":GdbStart gdb -q ", desc = "start gdb" },
      { "\\dl", ":GdbStartLLDB lldb ", desc = "start lldb" },
      { "\\dp", ":GdbStartPDB python -m pdb ", desc = "python gdb" },
      { "\\db", ":GdbStartBashDB bashdb ", desc = "start bashdb" },
      { "\\dr", ":GdbStartRR ", desc = "start bashdb" },
      { "\\da", ":packadd termdebug<cr>", desc = "add termdebug" },
      { "\\dg", ':let termdebugger="rust-gdb"', desc = "set debugger" },
    },
  },
}
