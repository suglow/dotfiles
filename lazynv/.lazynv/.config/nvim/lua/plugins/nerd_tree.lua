return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["o"] = "open",
          ["<C-]>"] = "set_root",
        },
      },
    },
    keys = {
      { "<leader><tab>", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader><tab>", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
    },
  },
}
