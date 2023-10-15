return {
  {
    "roobert/search-replace.nvim",
    config = function()
      require("search-replace").setup({
        -- optionally override defaults
        default_replace_single_buffer_options = "gcI",
        default_replace_multi_buffer_options = "egcI",
      })
    end,
    keys = {
      {
        "<leader>rw",
        "<CMD>SearchReplaceSingleBufferVisualSelection<CR>",
        mode = "v",
        noremap = true,
        desc = "SingleBufferVisualSelection",
      },
      {
        "<leader>rr",
        "<CMD>SearchReplaceWithinVisualSelection<CR>",
        mode = "v",
        noremap = true,
        desc = "WithinVisualSelection",
      },
      {
        "<leader>rs",
        "<CMD>SearchReplaceSingleBufferSelections<CR>",
        mode = "n",
        noremap = true,
        desc = "SingleBufferSelections",
      },
      {
        "<leader>ro",
        "<CMD>SearchReplaceSingleBufferOpen<CR>",
        mode = "n",
        noremap = true,
        desc = "SingleBufferOpen",
      },
      {
        "<leader>rw",
        "<CMD>SearchReplaceSingleBufferCWord<CR>",
        mode = "n",
        noremap = true,
        desc = "SingleBufferCWord",
      },
      {
        "<leader>rW",
        "<CMD>SearchReplaceSingleBufferCWORD<CR>",
        mode = "n",
        noremap = true,
        desc = "SingleBufferCWORD",
      },
      {
        "<leader>re",
        "<CMD>SearchReplaceSingleBufferCExpr<CR>",
        mode = "n",
        noremap = true,
        desc = "SingleBufferCExpr",
      },
      {
        "<leader>rf",
        "<CMD>SearchReplaceSingleBufferCFile<CR>",
        mode = "n",
        noremap = true,
        desc = "SingleBufferCFile",
      },
      {
        "<leader>rbs",
        "<CMD>SearchReplaceMultiBufferSelections<CR>",
        mode = "n",
        noremap = true,
        desc = "MultiBufferSelections",
      },
      {
        "<leader>rbo",
        "<CMD>SearchReplaceMultiBufferOpen<CR>",
        mode = "n",
        noremap = true,
        desc = "MultiBufferOpen",
      },
      {
        "<leader>rbw",
        "<CMD>SearchReplaceMultiBufferCWord<CR>",
        mode = "n",
        noremap = true,
        desc = "MultiBufferCWord",
      },
      {
        "<leader>rbW",
        "<CMD>SearchReplaceMultiBufferCWORD<CR>",
        mode = "n",
        noremap = true,
        desc = "MultiBufferCWORD",
      },
      {
        "<leader>rbe",
        "<CMD>SearchReplaceMultiBufferCExpr<CR>",
        mode = "n",
        noremap = true,
        desc = "MultiBufferCExpr",
      },
      {
        "<leader>rbf",
        "<CMD>SearchReplaceMultiBufferCFile<CR>",
        mode = "n",
        noremap = true,
        desc = "MultiBufferCFile",
      },
    },
  },
}
