---@type MappingsTable
local M = {}

M.disabled = {
  t = {
    -- toggle in terminal mode
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
  },

  n = {
    -- toggle in normal mode
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
    -- new
    ["<leader>h"] = "",
    ["<leader>v"] = "",
    -- cycle through buffers
    ["<tab>"] = "",

    ["<S-tab>"] = "",
    -- close buffer + hide terminal buffer
    ["<leader>x"] = "",
    ["<leader>b"] = "",
    ["<leader>/"] = "",
    ["<leader>pt"] = "",
    ["<leader>ph"] = "",
  },
  v = {
    ["<leader>/"] = "",
  }
}
M.general = {
	n = {
		-- [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["L"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["H"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },
    -- ["yow"] = { "<cmd>set wrap!<cr>", "Toggle wrap" },
    -- ["yoc"] = { "<cmd>set cursorline!<cr>", "Toggle cursorline" },
    -- ["yoh"] = { "<cmd>set hlsearch!<cr>", "Toggle hlsearch" },
    -- ["yoi"] = { "<cmd>set ignorecase!<cr>", "Toggle ignorecase" },
    -- ["yol"] = { "<cmd>set list!<cr>", "Toggle list" },
    -- ["yon"] = { "<cmd>set number!<cr>", "Toggle number" },
    -- ["yor"] = { "<cmd>set relativenumber!<cr>", "Toggle relativenumber" },
    -- ["yos"] = { "<cmd>set spell!<cr>", "Toggle spell" },
    -- ["you"] = { "<cmd>set cursorcolumn!<cr>", "Toggle cursorcolumn" },
    -- ["yov"] = { "<cmd>set virtualedit!<cr>", "Toggle virtualedit" },
	},
}

-- more keybinds!

return M
