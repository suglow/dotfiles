-- vim options

local opt = vim.opt
opt.relativenumber = false -- Relative line numbers
opt.shiftwidth = 2
opt.tabstop = 2
-- vim.cmd "set listchars=tab:→\\ ,eol:↲,nbsp:␣,space:•"
opt.listchars = {
  eol = "↲",
  space = "•",
  tab = "→\\ ",
  nbsp = "␣",
}
vim.opt.list = false

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = false,
  pattern = "*.lua",
  timeout = 1000,
}
