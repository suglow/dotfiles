return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          server = {
            -- cmd = { os.getenv "HOME" .. "/.local/bin/rust-analyzer" },
            -- cmd = { "rustup", "run", "nightly", os.getenv "HOME" .. "/.local/bin/rust-analyzer" },
            settings = {
              ["rust-analyzer"] = {
                lens = {
                  enable = true,
                },
                checkOnSave = {
                  command = "clippy",
                },
              },
            },
          },
        },
        pyright = {},
        lua_ls = {},
        clangd = {},
      },
      setup = {
        rust_analyzer = function(_, opts)
          require("rust-tools").setup(opts)
          return true
        end,
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },
  {
    "simrat39/rust-tools.nvim",
    dependencies = {
      "nvim-lspconfig",
    },
  },
}
