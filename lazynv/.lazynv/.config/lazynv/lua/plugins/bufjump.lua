return {
  {
    "kwkarlwang/bufjump.nvim",
    config = function()
      require("bufjump").setup({
        forward = "<A-i>",
        backward = "<A-o>",
        on_success = nil,
      })
    end,
  },
}
