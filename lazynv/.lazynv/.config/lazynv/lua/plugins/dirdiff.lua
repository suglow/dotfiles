return {
  {
    "ZSaberLv0/ZFVimJob",
    dependencies = { "ZSaberLv0/ZFVimDirDiff","ZSaberLv0/ZFVimIgnore" },
    init = function()
      vim.g.ZFIgnoreOption_ZFDirDiff = { bin = 0, media = 0, ZFDirDiff = 1, hidden = 1 }
    end,
  },
}
