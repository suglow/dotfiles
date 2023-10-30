return {
  {"suglow/nvim-dap-projects"},
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dc", function()
        local continue = function()
          -- if vim.fn.filereadable(".vscode/launch.json") then
          --   require("dap.ext.vscode").load_launchjs()
          -- end
          require("nvim-dap-projects").search_project_config()
          require("dap").continue()
        end
        continue()
      end, desc = "continue" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "step out" },
      { "<leader>do", function() require("dap").step_over() end, desc = "step over" },
      { "<leader>dB", false},
      { "<leader>db", false},
    },
  },
  {
    'Weissle/persistent-breakpoints.nvim',
    event = "VeryLazy",
    opts = {
      load_breakpoints_event = { "BufReadPost" }
    },
    keys = {
      { "<leader>dB", function() require('persistent-breakpoints.api').set_conditional_breakpoint() end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require('persistent-breakpoints.api').toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    },
  },
}
