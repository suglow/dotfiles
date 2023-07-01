return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "rust",
        "json",
        "toml",
        "llvm",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<A-.>",
          node_incremental = "<A-.>",
          scope_incremental = false,
          node_decremental = "<A-,>",
        },
      },
    },
    keys = {
      { "<A-.>", desc = "Increment selection" },
      { "<A-,>", desc = "Decrement selection", mode = "x" },
    },
  },
}
