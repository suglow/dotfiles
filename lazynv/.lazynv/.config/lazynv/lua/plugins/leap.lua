return {
  {
    "ggandor/leap.nvim",
    opts = {
      safe_labels = {
        "a",
        "b",
        "s",
        "f",
        "n",
        "d",
        "w",
        "e",
        "m",
        "b",
        "u",
        "r",
        "g",
        "t",
        "n",
        "z",
      },
      labels = {
        "s",
        "f",
        "n",
        "j",
        "k",
        "l",
        "h",
        "o",
        "d",
        "w",
        "e",
        "m",
        "b",
        "u",
        "y",
        "v",
        "r",
        "g",
        "t",
        "c",
        "x",
        "/",
        "z",
      },
    },
    keys = nil,
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.setup(opts)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },
}
