return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    dependencies = {
      "nvim-neorg/tree-sitter-norg",
      "nvim-neorg/tree-sitter-norg-meta",
    },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.export"] = {},
          ["core.export.markdown"] = {},
          ["core.keybinds"] = {
            config = {
              neorg_leader = ",",
            },
          },
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "/workspace/notes",
              },
            },
          },
        },
      })
    end,
  },
}
