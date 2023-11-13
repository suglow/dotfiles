return {
  {
    "sindrets/diffview.nvim",
    opts = {
      view = {
        merge_tool = {
          layout = "diff4_mixed",
        },
      },
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
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", mode = { "n" }, desc = "Repo Diffview", nowait = true },
      { "<leader>gf", "<cmd>DiffviewFileHistory --follow %<cr>", mode = { "n" }, desc = "File history" },
      {
        "<leader>gl",
        function()
          local current_line = vim.fn.line(".")
          local file = vim.fn.expand("%")
          -- DiffviewFileHistory --follow -L{current_line},{current_line}:{file}
          local cmd = string.format("DiffviewFileHistory --follow -L%s,%s:%s", current_line, current_line, file)
          vim.cmd(cmd)
        end,
        desc = "Line history",
      },
    },
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
