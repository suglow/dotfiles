return {
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "LspAttach",
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({
        update_in_insert = false,
        signs = false,
        severity_sort = true,
        virtual_text = false, -- Since we're using lsp_lines
        virtual_lines = false,
      }, require("lazy.core.config").ns)
    end,
    keys = {
      { "<leader>ln", require("lsp_lines").toggle, desc = "Toggle lsp_lines" },
    },
  },
}
