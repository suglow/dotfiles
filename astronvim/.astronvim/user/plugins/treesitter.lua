return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
      -- "lua"
    })
    opts.incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<A-.>",
        node_incremental = "<A-.>",
        scope_incremental = false,
        node_decremental = "<A-,>",
      },
    }
  end,
  keys = {
    { "<A-.>", desc = "Increment selection" },
    { "<A-,>", desc = "Decrement selection", mode = "x" },
  },
}
