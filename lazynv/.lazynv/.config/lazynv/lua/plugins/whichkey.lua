return {
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader><tab>"] = { "<leader>fE", "Explorer NeoTree (cwd)", remap = true },
        ["<leader>a"] = { "<cmd>Alpha<cr>", "Alpha" },
        ["<leader>l"] = vim.NIL,
        ["<leader>p"] = { "<cmd>Lazy<cr>", "Lazy" },
        ["yo"] = {
          w = { "<cmd>set wrap!<cr>", "Toggle wrap" },
          c = { "<cmd>set cursorline!<cr>", "Toggle cursorline" },
          h = { "<cmd>set hlsearch!<cr>", "Toggle hlsearch" },
          i = { "<cmd>set ignorecase!<cr>", "Toggle ignorecase" },
          l = { "<cmd>set list!<cr>", "Toggle list" },
          n = { "<cmd>set number!<cr>", "Toggle number" },
          r = { "<cmd>set relativenumber!<cr>", "Toggle relativenumber" },
          s = { "<cmd>set spell!<cr>", "Toggle spell" },
          u = { "<cmd>set cursorcolumn!<cr>", "Toggle cursorcolumn" },
          v = { "<cmd>set virtualedit!<cr>", "Toggle virtualedit" },
        },
      },
    },
  },
}
