return {
  { "ibhagwan/smartyank.nvim" },
  {
    "gbprod/yanky.nvim",
    opts = function(_, opts)
      local utils = require("yanky.utils")
      local mapping = require("yanky.telescope.mapping")
      opts = vim.tbl_deep_extend("force", opts, {
        ring = {
          history_length = 100,
          storage = "shada",
          sync_with_numbered_registers = true,
          cancel_event = "update",
        },
        picker = {
          select = {
            action = nil, -- nil to use default put action
          },
          telescope = {
            mappings = {
              default = mapping.put("p"),
              i = {
                ["<c-p>"] = mapping.put("p"),
                ["<c-k>"] = mapping.put("P"),
                ["<c-x>"] = mapping.delete(),
                ["<c-r>"] = mapping.set_register(utils.get_default_register()),
              },
              n = {
                p = mapping.put("p"),
                P = mapping.put("P"),
                d = mapping.delete(),
                r = mapping.set_register(utils.get_default_register()),
              },
            },
          },
        },
        system_clipboard = {
          sync_with_ring = true,
        },
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 500,
        },
        preserve_cursor_position = {
          enabled = true,
        },
      })
    end,
    config = function(_, opts)
      vim.notify(vim.inspect(opts))
      require("yanky").setup(opts)
      require("telescope").load_extension("yank_history")
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>sy", "<cmd>Telescope yank_history<CR>", desc = "yank history" },
    },
  },
}
