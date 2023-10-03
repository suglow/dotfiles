return {
  {
    "ZSaberLv0/ZFVimJob",
    dependencies = { "ZSaberLv0/ZFVimDirDiff"},
    init = function()
      -- vim.g.ZFIgnoreOption_ZFDirDiff = { bin = 1, media = 1, ZFDirDiff = 1, hidden = 0, common = 0, gitignore = 0 }
      vim.g.ZFDirDiff_excludeCheck_fallback_patterns = {
                   "^\\~.*$",
                   "^.*\\~$",
      }
    end,
  },
}
