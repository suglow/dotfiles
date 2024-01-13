-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
vim.keymap.del("n", "<leader><tab>l")
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>d")
vim.keymap.del("n", "<leader><tab>[")
vim.keymap.del("n", "<leader>l")

-- vim.keymap.del("n", "<C-h>")
-- vim.keymap.del("n", "<C-j>")
-- vim.keymap.del("n", "<C-k>")
-- vim.keymap.del("n", "<C-l>")

vim.keymap.del("n", "<C-Up>")
vim.keymap.del("n", "<C-Down>")
vim.keymap.del("n", "<C-Left>")
vim.keymap.del("n", "<C-Right>")

-- vim.keymap.set("n", "C-h", "<cmd>lua require('tmux').move_left()<cr>", { noremap = true, desc = "move left" })
-- vim.keymap.set("n", "C-j", "<cmd>lua require('tmux').move_bottom()<cr>", { noremap = true, desc = "move bottom" })
-- vim.keymap.set("n", "C-k", "<cmd>lua require('tmux').move_top()<cr>", { noremap = true, desc = "move top" })
-- vim.keymap.set("n", "C-l", "<cmd>lua require('tmux').move_right()<cr>", { noremap = true, desc = "move right" })
-- Resize window using <ctrl> arrow keys
-- vim.keymap.del("n", "s")
-- vim.keymap.del("n", "S")
-- vim.keymap.del("x", "s")
-- vim.keymap.del("x", "S")

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
-- vim.keymap.set("n", "<A-j>", "<cmd>resize -2<CR>", { noremap = true, desc = "resize up" })
-- vim.keymap.set("n", "<A-k>", "<cmd>resize +2<CR>", { noremap = true, desc = "resize down" })
-- vim.keymap.set("n", "<A-h>", "<cmd>vertical resize -2<CR>", { noremap = true, desc = "resize left" })
-- vim.keymap.set("n", "<A-l>", "<cmd>vertical resize +2<CR>", { noremap = true, desc = "resize right" })

vim.keymap.set("n", "<Down>", "<Down>zz", { noremap = true })
vim.keymap.set("n", "<Up>", "<Up>zz", { noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
