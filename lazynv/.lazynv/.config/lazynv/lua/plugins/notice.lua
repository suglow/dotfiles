return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- cmdline = {
      -- view = "cmdline",
      -- },
      presets = {
        bottom_search = true,
      },
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
