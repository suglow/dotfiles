local actions = require("telescope.actions")

return {
  {
    "nvim-telescope/telescope.nvim",
    -- change some options
    opts = {
      defaults = {
        layout_config = {
          horizontal = {
            width = 0.98,
            height = 0.95,
            prompt_position = "bottom",
            preview_cutoff = 120,
          },

          vertical = {
            width = 0.8,
            height = 0.6,
            prompt_position = "bottom",
            preview_cutoff = 40,
          },

          center = {
            width = 0.8,
            height = 0.6,
            preview_cutoff = 40,
            prompt_position = "top",
          },

          cursor = {
            width = 0.8,
            height = 0.9,
            preview_cutoff = 40,
          },

          bottom_pane = {
            height = 25,
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        --
        initial_mode = "normal",
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
        sorting_strategy = "descending",
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
        file_ignore_patterns = {
          "node_modules",
          ".work/.*",
          ".cache/.*",
          ".idea/.*",
          "dist/.*",
          ".git/.*",
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,

            ["<C-Down>"] = require("telescope.actions").cycle_history_next,
            ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,

            ["<C-c>"] = actions.close,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-l>"] = actions.complete_tag,
            ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
          },

          n = {
            ["<esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["H"] = actions.move_to_top,
            ["M"] = actions.move_to_middle,
            ["L"] = actions.move_to_bottom,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,
            ["g"] = actions.close,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            -- ["?"] = actions.which_key,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f" },
          hidden = true,
          no_ignore = false,
        },
      },
      extensions = {
        fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
        },
      },
    },
    keys = {
      { "<leader>ff", false },
      { "<leader>sg", false },
      { "<leader>/", false },
      { "<leader><space>", "<cmd>Telescope oldfiles<cr>", desc = "rescent files" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzy-native.nvim",
      config = function()
        require("telescope").load_extension("fzy_native")
      end,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-live-grep-args.nvim",
      config = function()
        require("telescope").load_extension("live_grep_args")
      end,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "bookmarks.nvim",
    },
  },
}
