return {
  {
    "ecthelionvi/NeoComposer.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    opts = {
      keymaps = {
        play_macro = "Q",
        yank_macro = "yq",
        stop_macro = "cq",
        toggle_record = "q",
        cycle_next = "<a-n>",
        cycle_prev = "<a-p>",
        toggle_macro_menu = "<a-q>",
      },
    },
  },
}
