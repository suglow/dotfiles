local select_objects = {
  aa = "@parameter.outer",
  ia = "@parameter.inner",
  af = "@function.outer",
  ["if"] = "@function.inner",
  ac = "@class.outer",
  ic = "@class.inner",
  ii = "@conditional.inner",
  ai = "@conditional.outer",
  il = "@loop.inner",
  al = "@loop.outer",
  at = "@comment.outer",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "c", "cpp", "rust", "json", "toml", "llvm", "lua" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    opts = {
      select = { lookahead = true },
      move = {
        enable = true,
        set_jumps = true,
        keys = {
          goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
          goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
          goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
          goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
        },
      },
    },
    keys = function(_, keys)
      for lhs, query in pairs(select_objects) do
        local capture = query
        keys[#keys + 1] = {
          lhs,
          function()
            require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
          end,
          mode = { "x", "o" },
          desc = "Select " .. capture,
        }
      end
    end,
  },
}
