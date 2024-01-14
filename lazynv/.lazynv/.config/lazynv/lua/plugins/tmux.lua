return {
  {
    "suglow/tmux.nvim",
    config = function()
      return require("tmux").setup({
        copy_sync = {
          enable = false,
          sync_clipboard = false,
          sync_registers = false,
        },
        navigation = {
          persist_zoom = true,
          cycle_navigation = false,
          enable_default_keybindings = false,
        },
        resize = {
          enable_default_keybindings = false,
        },
      })
    end,
    keys = {
      { "<C-h>", "<cmd>lua require('tmux').move_left()<cr>", desc = "move left" },
      { "<C-j>", "<cmd>lua require('tmux').move_bottom()<cr>", desc = "move bottom" },
      { "<C-k>", "<cmd>lua require('tmux').move_top()<cr>", desc = "move top" },
      { "<C-l>", "<cmd>lua require('tmux').move_right()<cr>", desc = "move right" },
      { "<A-h>", "<cmd>lua require('tmux').resize_left()<cr>", desc = "resize left" },
      { "<A-j>", "<cmd>lua require('tmux').resize_bottom()<cr>", desc = "resize bottom" },
      { "<A-k>", "<cmd>lua require('tmux').resize_top()<cr>", desc = "resize top" },
      { "<A-l>", "<cmd>lua require('tmux').resize_right()<cr>", desc = "resize right" },
    },
  },
}
