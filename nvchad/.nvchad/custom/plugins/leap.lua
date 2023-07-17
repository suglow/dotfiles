return {
  {
    "ggandor/leap.nvim",
    enabled = false,
    opts = {
      safe_labels = {
        "a",
        "b",
        "s",
        "n",
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
        "n",
        "j",
        "k",
        "l",
        "h",
        "o",
        "w",
        "e",
        "m",
        "b",
        "u",
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
    end,
  },
}
