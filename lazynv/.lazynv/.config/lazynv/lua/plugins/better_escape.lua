return {
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({
        mapping = { "jk" }, -- a table with mappings to use
        timeout = 300,
        clear_empty_lines = false, -- clear line after escaping if there is only whitespace
        keys = "<Esc>", -- keys usejkkk
      })
    end,
  },
}
