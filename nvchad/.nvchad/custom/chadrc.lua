---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "tokyonight",
  theme_toggle = { "tokyonight", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
  -- nvdash = {
  --   load_on_startup = false,
  --   buttons = {
  --     { "  Config", "c", "e $MYVIMRC" },
  --     { "  Find File", "f", "Telescope find_files" },
  --     { "󰈚  Recent Files", "r", "Telescope oldfiles" },
  --     { "󰈭  Find Word", "s", "Telescope live_grep" },
  --     { "  Bookmarks", "m", "Telescope marks" },
  --     { "  Themes", "h", "Telescope themes" },
  --     { "  Mappings", "c", "NvCheatsheet" },
  --   }
  -- }
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

M.lazy_nvim = {
  defaults = { lazy = false },
}

return M
