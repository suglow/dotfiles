return {
  {
    "chrisgrieser/nvim-alt-substitute",
    opts = true,
    -- lazy-loading with `cmd =` does not work well with incremental preview
    event = "CmdlineEnter",
    keys = {
      { "<leader>ra", ":S ///g<Left><Left><Left>", { "n", "x" }, desc = "󱗘 :AltSubstitute" },
      {
        "<leader>rA",
        function()
          return ":S /" .. vim.fn.expand("<cword>") .. "//g<Left><Left>"
        end,
        { "n", "x" },
        desc = "󱗘 :AltSubstitute (word under cursor)",
        expr = true,
      },
    },
  },
}
