return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- cmdline = {
      -- view = "cmdline",
      -- },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 150,
            height = "auto",
          },
          win_options = {
            wrap = true,
          },
        },
      },
    },
  },
}
