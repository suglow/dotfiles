local Util = require("lazyvim.util")
local function getTelescopeOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if filename == nil then
          filename = selection[1]
        end
        -- any way to open the file without triggering auto-close event of neo-tree?
        require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
      end)
      return true
    end,
  }
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["o"] = "custem_open",
          ["<C-]>"] = "set_root",
          ["<space>"] = vim.NIL,
          ["<C-f>"] = "telescope_find",
          ["<C-g>"] = "telescope_grep",
          ["<C-d>"] = "telescope_grep_args",
          ["/"] = "telescope_find_file",
        },
      },
      commands = {
        custem_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          local parent = node:get_parent_id()
          local util = require("neo-tree.utils")
          local fs = require("neo-tree.sources.filesystem.commands")
          if parent == nil then
            path = util.path_join(path, "/../")
            path = vim.fn.resolve(path)
            fs.navigate_up(state)
          else
            fs.open(state)
          end
        end,
        telescope_find = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require("telescope.builtin").find_files(getTelescopeOpts(state, path))
        end,
        telescope_grep = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require("telescope.builtin").live_grep(getTelescopeOpts(state, path))
        end,
        telescope_grep_args = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require("telescope").extensions.live_grep_args.live_grep_args(getTelescopeOpts(state, path))
        end,
        telescope_find_file = function(state)
          local path = require("lazyvim.util").get_root()
          require("telescope.builtin").find_files(getTelescopeOpts(state, path))
        end,
      },
      filesystem = {
        follow_current_file = true,
        bind_to_cwd = false,
        filtered_items = {
          hide_dotfiles = false,
          hide_hidden = true,
        },
      },
    },
    keys = {
      { "<leader><tab>", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader><tab>", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
    },
  },
  -- dependencies = { "nvim-telescope/telescope.nvim" },
}
