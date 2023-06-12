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
vim.keymap.del("n", "s")
vim.keymap.del("n", "S")
vim.keymap.del("x", "s")
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
vim.keymap.set("n", "<A-j>", ":resize -2<CR>", { noremap = true, desc = "resize up" })
vim.keymap.set("n", "<A-k>", ":resize +2<CR>", { noremap = true, desc = "resize down" })
vim.keymap.set("n", "<A-h>", ":vertical resize -2<CR>", { noremap = true, desc = "resize left" })
vim.keymap.set("n", "<A-l>", ":vertical resize +2<CR>", { noremap = true, desc = "resize right" })

-- Alt Substitue
-- prefill commandline with Substitution Syntax
vim.keymap.set({ "n", "x" }, "<leader>ra", [[:S ///g<Left><Left><Left>]], { desc = "󱗘 :AltSubstitute" })
-- prefill commandline with Substitution Syntax and word under cursor
vim.keymap.set({ "n", "x" }, "<leader>rA", function()
  return ":S /" .. vim.fn.expand("<cword>") .. "//g<Left><Left>"
end, { desc = "󱗘 :AltSubstitute (word under cursor)", expr = true })

vim.keymap.set(
  "v",
  "<leader>rw",
  "<CMD>SearchReplaceSingleBufferVisualSelection<CR>",
  { noremap = true, desc = "SingleBufferVisualSelection" }
)
vim.keymap.set(
  "v",
  "<leader>rs",
  "<CMD>SearchReplaceWithinVisualSelection<CR>",
  { noremap = true, desc = "WithinVisualSelection" }
)

vim.keymap.set(
  "n",
  "<leader>rs",
  "<CMD>SearchReplaceSingleBufferSelections<CR>",
  { noremap = true, desc = "SingleBufferSelections" }
)
vim.keymap.set(
  "n",
  "<leader>ro",
  "<CMD>SearchReplaceSingleBufferOpen<CR>",
  { noremap = true, desc = "SingleBufferOpen" }
)
vim.keymap.set(
  "n",
  "<leader>rw",
  "<CMD>SearchReplaceSingleBufferCWord<CR>",
  { noremap = true, desc = "SingleBufferCWord" }
)
vim.keymap.set(
  "n",
  "<leader>rW",
  "<CMD>SearchReplaceSingleBufferCWORD<CR>",
  { noremap = true, desc = "SingleBufferCWORD" }
)
vim.keymap.set(
  "n",
  "<leader>re",
  "<CMD>SearchReplaceSingleBufferCExpr<CR>",
  { noremap = true, desc = "SingleBufferCExpr" }
)
vim.keymap.set(
  "n",
  "<leader>rf",
  "<CMD>SearchReplaceSingleBufferCFile<CR>",
  { noremap = true, desc = "SingleBufferCFile" }
)

vim.keymap.set(
  "n",
  "<leader>rbs",
  "<CMD>SearchReplaceMultiBufferSelections<CR>",
  { noremap = true, desc = "MultiBufferSelections" }
)
vim.keymap.set(
  "n",
  "<leader>rbo",
  "<CMD>SearchReplaceMultiBufferOpen<CR>",
  { noremap = true, desc = "MultiBufferOpen" }
)
vim.keymap.set(
  "n",
  "<leader>rbw",
  "<CMD>SearchReplaceMultiBufferCWord<CR>",
  { noremap = true, desc = "MultiBufferCWord" }
)
vim.keymap.set(
  "n",
  "<leader>rbW",
  "<CMD>SearchReplaceMultiBufferCWORD<CR>",
  { noremap = true, desc = "MultiBufferCWORD" }
)
vim.keymap.set(
  "n",
  "<leader>rbe",
  "<CMD>SearchReplaceMultiBufferCExpr<CR>",
  { noremap = true, desc = "MultiBufferCExpr" }
)
vim.keymap.set(
  "n",
  "<leader>rbf",
  "<CMD>SearchReplaceMultiBufferCFile<CR>",
  { noremap = true, desc = "MultiBufferCFile" }
)
