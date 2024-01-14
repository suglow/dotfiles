return {
  {
    "suglow/lsp_lines.nvim",
    event = "LspAttach",
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({
        update_in_insert = false,
        signs = true,
        severity_sort = true,
        virtual_text = false, -- Since we're using lsp_lines
        virtual_lines = true,
      })
    end,
    keys = {
      { "<leader>ln", "<cmd>lua require('lsp_lines').toggle()<cr>", desc = "Toggle lsp_lines" },
    }
  },
}
