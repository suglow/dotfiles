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
        "v",
        noremap = true,
        desc = "SingleBufferVisualSelection",
      },
      {
        "<leader>rs",
        "<CMD>SearchReplaceWithinVisualSelection<CR>",
        "v",
        noremap = true,
        desc = "WithinVisualSelection",
      },
      {
        "<leader>rs",
        "<CMD>SearchReplaceSingleBufferSelections<CR>",
        "n",
        noremap = true,
        desc = "SingleBufferSelections",
      },
      {
        "<leader>ro",
        "<CMD>SearchReplaceSingleBufferOpen<CR>",
        "n",
        noremap = true,
        desc = "SingleBufferOpen",
      },
      {
        "<leader>rw",
        "<CMD>SearchReplaceSingleBufferCWord<CR>",
        "n",
        noremap = true,
        desc = "SingleBufferCWord",
      },
      {
        "<leader>rW",
        "<CMD>SearchReplaceSingleBufferCWORD<CR>",
        "n",
        noremap = true,
        desc = "SingleBufferCWORD",
      },
      {
        "<leader>re",
        "<CMD>SearchReplaceSingleBufferCExpr<CR>",
        "n",
        noremap = true,
        desc = "SingleBufferCExpr",
      },
      {
        "<leader>rf",
        "<CMD>SearchReplaceSingleBufferCFile<CR>",
        "n",
        noremap = true,
        desc = "SingleBufferCFile",
      },
      {
        "<leader>rbs",
        "<CMD>SearchReplaceMultiBufferSelections<CR>",
        "n",
        noremap = true,
        desc = "MultiBufferSelections",
      },
      {
        "<leader>rbo",
        "<CMD>SearchReplaceMultiBufferOpen<CR>",
        "n",
        noremap = true,
        desc = "MultiBufferOpen",
      },
      {
        "<leader>rbw",
        "<CMD>SearchReplaceMultiBufferCWord<CR>",
        "n",
        noremap = true,
        desc = "MultiBufferCWord",
      },
      {
        "<leader>rbW",
        "<CMD>SearchReplaceMultiBufferCWORD<CR>",
        "n",
        noremap = true,
        desc = "MultiBufferCWORD",
      },
      {
        "<leader>rbe",
        "<CMD>SearchReplaceMultiBufferCExpr<CR>",
        "n",
        noremap = true,
        desc = "MultiBufferCExpr",
      },
      {
        "<leader>rbf",
        "<CMD>SearchReplaceMultiBufferCFile<CR>",
        "n",
        noremap = true,
        desc = "MultiBufferCFile",
      },
    },
  },
}
