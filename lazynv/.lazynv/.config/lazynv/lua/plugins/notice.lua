return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- cmdline = {
      -- view = "cmdline",
      -- },
      cmdline = {
        format = {
          search_down = {
            view = "cmdline",
          },
          search_up = {
            view = "cmdline",
          },
          substitute = {
            view = "cmdline",
            pattern = "^:S%s+",
          },
          substitute_range = {
            view = "cmdline",
            pattern = "^:'<,'>S%s+",
          },
          replacement = {
            view = "cmdline",
            pattern = "^:%%s",
          },
          replacement_range = {
            view = "cmdline",
            pattern = "^:'<,'>s",
          },
        },
      },
      presets = {
        bottom_search = false,
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
