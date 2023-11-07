return {
  {
    "sindrets/diffview.nvim",
    opts = {
      hooks = {
        diff_buf_win_enter = function(bufnr, winid, ctx)
          if ctx.layout_name:match("^diff2") then
            if ctx.symbol == "a" then
              vim.opt_local.winhl = table.concat({
                "DiffAdd:DiffviewDiffAddAsDelete",
                "DiffDelete:DiffviewDiffDelete",
              }, ",")
            elseif ctx.symbol == "b" then
              vim.opt_local.winhl = table.concat({
                "DiffDelete:DiffviewDiffDelete",
              }, ",")
            end
          end
        end,
      },
    },
    dependencies = "nvim-lua/plenary.nvim",
  },
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
