-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
--

vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", { noremap = true, desc = "window move right" })
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", { noremap = true, desc = "window move left" })

-- vim.keymap.set("c", "jk", "<C-C>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-b>", "<ESC>^i", { noremap = true, silent = true })
vim.keymap.set("i", "<C-e>", "<ESC>g_a", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>rr", "viwP", { noremap = true, desc = "repace world" })
-- Visual Block --
-- Move text up and down
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", { noremap = true, desc = "move line down" })
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", { noremap = true, desc = "move line up" })

vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", { noremap = true, desc = "move select down" })
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", { noremap = true, desc = "move select up" })

-- Resize with arrows
vim.keymap.set("n", "<A-j>", "<cmd>resize -2<CR>", { noremap = true, desc = "resize up" })
vim.keymap.set("n", "<A-k>", "<cmd>resize +2<CR>", { noremap = true, desc = "resize down" })
vim.keymap.set("n", "<A-h>", "<cmd>vertical resize -2<CR>", { noremap = true, desc = "resize left" })
vim.keymap.set("n", "<A-l>", "<cmd>vertical resize +2<CR>", { noremap = true, desc = "resize right" })

vim.keymap.set("n", "<Down>", "<Down>zz", { noremap = true })
vim.keymap.set("n", "<Up>", "<Up>zz", { noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>a"] = { "<cmd>Alpha<CR>", desc = "Dashboard" },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>fr"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" },
    ["<leader><tab>"] = {
      "<cmd>Neotree toggle<cr>",
      desc = "Explorer NeoTree ",
    },
    ["yo"] = {
      w = { "<cmd>set wrap!<cr>", "Toggle wrap" },
      c = { "<cmd>set cursorline!<cr>", "Toggle cursorline" },
      h = { "<cmd>set hlsearch!<cr>", "Toggle hlsearch" },
      i = { "<cmd>set ignorecase!<cr>", "Toggle ignorecase" },
      l = { "<cmd>set list!<cr>", "Toggle list" },
      n = { "<cmd>set number!<cr>", "Toggle number" },
      r = { "<cmd>set relativenumber!<cr>", "Toggle relativenumber" },
      s = { "<cmd>set spell!<cr>", "Toggle spell" },
      u = { "<cmd>set cursorcolumn!<cr>", "Toggle cursorcolumn" },
      v = { "<cmd>set virtualedit!<cr>", "Toggle virtualedit" },
    },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
