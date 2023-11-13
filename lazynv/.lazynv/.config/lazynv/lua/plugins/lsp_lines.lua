return {
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      -- https://github.com/folke/lazy.nvim/issues/620
      -- vim.diagnostic.config({ virtual_text = false, }, require("lazy.core.config").ns)
      -- vim.diagnostic.config({ virtual_lines = { prefix = "" } })
      vim.diagnostic.config({
        update_in_insert = false,
        signs = false,
        severity_sort = true,
        virtual_text = false, -- Since we're using lsp_lines
        virtual_lines = false,
      }, require("lazy.core.config").ns)
      vim.diagnostic.config({ virtual_lines = { prefix = "" } })
    end,
    keys = {
      { "<leader>ln", require("lsp_lines").toggle, desc = "Toggle lsp_lines" },
    }
  },
}
