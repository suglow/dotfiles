return {
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension("frecency")
    end,
    keys = {
      { "<leader><space>", "<cmd>Telescope frecency<cr>", desc = "rescent files" },
    },
  },
}
