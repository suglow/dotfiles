return {
  {
    "neovim/nvim-lspconfig",
    init = function ()
      vim.g.autoformat = false
    end,
    opts = {
      -- autoformat = false,
      -- diagnostics = {
      --   underline = true,
      --   update_in_insert = false,
      --   virtual_text = false,
      --   severity_sort = true,
      -- },
      inlay_hints = {
        enabled = false,
      },
      servers = {
      },
      setup = {
        -- clangd = function(_, opts)
        --   opts.capabilities.offsetEncoding = { "utf-16" }
        -- end,
        -- gopls = function(_, opts)
        --   local go_opts = {
        --     lsp_cfg = opts,
        --     luasnip = true,
        --   }
        --   require("go").setup(go_opts)
        --   return true
        -- end,
      },
    },
    keys = {
      {
        "<leader>lD",
        function()
          if vim.diagnostic.is_disabled() then
            vim.diagnostic.enable()
          else
            vim.diagnostic.disable()
          end
        end,
        desc = "trogger lsp",
      },
    },
  },
}
