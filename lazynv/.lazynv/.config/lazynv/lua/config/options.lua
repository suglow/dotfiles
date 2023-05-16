-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
opt.relativenumber = false -- Relative line numbers
-- vim.cmd "set listchars=tab:→\\ ,eol:↲,nbsp:␣,space:•"
opt.listchars = {
  eol = "↲",
  space = "•",
  tab = "→\\ ",
  nbsp = "␣",
}
vim.opt.list = false
