-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--
-- opts
local opt = vim.opt
opt.relativenumber = false -- Relative line numbers
-- vim.cmd "set listchars=tab:→\\ ,eol:↲,nbsp:␣,space:•"
opt.listchars = {
  eol = "↲",
  space = "•",
  tab = "→\\ ",
  nbsp = "␣",
}
opt.list = false
opt.inccommand = "split"

-- key maps
vim.g.termdebug_wide = 1
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", { noremap = true, desc = "window move right" })
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", { noremap = true, desc = "window move left" })

-- vim.keymap.set("c", "jk", "<C-C>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-b>", "<ESC>^i", { noremap = true, silent = true })
vim.keymap.set("i", "<C-e>", "<ESC>g_a", { noremap = true, silent = true })

-- Move text up and down
vim.keymap.set("n", "<leader>rr", "viwP", { noremap = true, desc = "repace world" })
-- Visual Block --
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
