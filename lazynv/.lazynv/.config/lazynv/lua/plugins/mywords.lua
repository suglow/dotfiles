return {
  {
    "dwrdx/mywords.nvim",
    keys = {
      { "<leader>hw", "<cmd>lua require'mywords'.hl_toggle()<cr>", desc = "hl world" },
      { "<leader>hc", "<cmd>lua require'mywords'.uhl_all()<cr>", desc = "unhl" },
    },
  },
}
