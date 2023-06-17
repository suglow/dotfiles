return {
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader><tab>"] = { "<leader>fE", "Explorer NeoTree (cwd)", remap = true },
        ["<leader>a"] = { "<cmd>Alpha<cr>", "Alpha" },
        ["<leader>p"] = { "<cmd>Lazy<cr>", "Lazy" },
        ["<leader>sj"] = { "<cmd>Telescope jumplist<cr>", "Jump list" },
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
        ["<leader>l"] = {
          name = "LSP",
          a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
          d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
          w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
          f = { "<cmd>lua require('lvim.lsp.utils').format()<cr>", "Format" },
          i = { "<cmd>LspInfo<cr>", "Info" },
          I = { "<cmd>Mason<cr>", "Mason Info" },
          j = {
            "<cmd>lua vim.diagnostic.goto_next()<cr>",
            "Next Diagnostic",
          },
          k = {
            "<cmd>lua vim.diagnostic.goto_prev()<cr>",
            "Prev Diagnostic",
          },
          l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
          q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
          r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
          s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
          S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
          },
          e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
        },
      },
    },
  },
}
