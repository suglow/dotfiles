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

vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", { noremap = true, desc = "window move right" })
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", { noremap = true, desc = "window move left" })

vim.keymap.set("n", "<leader>r", "viwP", { noremap = true, desc = "repace world" })
-- Visual Block --
-- Move text up and down
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", { noremap = true, desc = "move line down" })
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", { noremap = true, desc = "move line up" })

vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", { noremap = true, desc = "move select down" })
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", { noremap = true, desc = "move select up" })
