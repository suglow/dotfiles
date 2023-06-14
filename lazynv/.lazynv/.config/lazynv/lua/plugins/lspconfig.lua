return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          server = {
            --[[
        $ mkdir -p ~/.local/bin
        $ curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
        $ chmod +x ~/.local/bin/rust-analyzer
    --]]
            -- cmd = { os.getenv "HOME" .. "/.local/bin/rust-analyzer" },
            -- cmd = { "rustup", "run", "nightly", os.getenv "HOME" .. "/.local/bin/rust-analyzer" },
            -- on_attach = require("user.lsp.handlers").on_attach,
            -- capabilities = require("user.lsp.handlers").capabilities,
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
