return {
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  {
    "NeogitOrg/neogit",
    opts = {
      disable_commit_confirmation = true,
      integrations = {
        diffview = true,
      },
      mappings = {
        status = {
          ["<tab>"] = false,
          ["o"] = "Toggle",
        },
      },
    },
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    keys = {
      { "\\g", "<cmd>Neogit<cr>", desc = "start neogit" },
    },
  },
}
