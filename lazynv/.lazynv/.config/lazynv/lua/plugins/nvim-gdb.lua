return {
  {
    "sakhnik/nvim-gdb",
    build = ":!./install.sh",
    init = function()
      vim.g.nvimgdb_disable_start_keymaps = true

      vim.g.nvimgdb_config_override = {
        key_next = "<f10>",
        key_step = "<f11>",
        key_finish = "<f2>",
        key_continue = "<f5>",
        key_until = "<f6>",
        key_breakpoint = "<f9>",
      }
    end,
  },
}
