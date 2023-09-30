local M = {
  resentGrepFolder = nil,
}

local function getGrepTelescopeOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      local fs = require("neo-tree.sources.filesystem.commands")
      local utils = require("neo-tree.utils")
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if filename == nil then
          filename = selection[1]
        end
        -- vim.notify(filename)
        local row = selection.row or selection.lnum
        local col = selection.col
        -- any way to open the file without triggering auto-close event of neo-tree?
        require("neo-tree.sources.filesystem").navigate(state, state.path, filename)

        utils.open_file(state, filename)
        vim.api.nvim_win_set_cursor(0, { row, col })
      end)
      return true
    end,
  }
end

local function getTelescopeOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      local utils = require("neo-tree.utils")
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
        utils.open_file(state, filename)
      end)
      return true
    end,
  }
end

local function copy_to_clipboard(content)
  vim.fn.setreg("+", content)
  vim.fn.setreg('"', content)
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
          ["D"] = "dir_mark",
          ["B"] = "diff_files",
          ["<C-f>"] = "telescope_find",
          ["<C-g>"] = "telescope_grep",
          ["<C-d>"] = "telescope_grep_args",
          ["<C-t>"] = "open_term",
          ["gy"] = "copy_node_name",
          ["gu"] = "navigate_up_dir",
          ["/"] = "noop",
          ["f"] = "noop",
        },
      },
      commands = {
        custem_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          local parent = node:get_parent_id()
          local util = require("neo-tree.utils")
          local fs = require("neo-tree.sources.filesystem.commands")
          local loc = require("neo-tree.sources.filesystem")
          if parent == nil then
            path = util.path_join(path, "/../")
            path = vim.fn.resolve(path)
            fs.navigate_up(state)
            loc.navigate(state, path, path)
          else
            fs.open(state)
          end
        end,
        telescope_find = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          M.resentGrepFolder = path
          require("telescope.builtin").find_files(getTelescopeOpts(state, path))
        end,
        telescope_grep = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          M.resentGrepFolder = path
          require("telescope.builtin").live_grep(getGrepTelescopeOpts(state, path))
        end,
        telescope_grep_args = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          M.resentGrepFolder = path
          require("telescope").extensions.live_grep_args.live_grep_args(getGrepTelescopeOpts(state, path))
        end,
        telescope_find_file = function(state)
          local path = require("lazyvim.util").get_root()
          M.resentGrepFolder = path
          require("telescope.builtin").find_files(getTelescopeOpts(state, path))
        end,
        copy_node_name = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          copy_to_clipboard(path)
          vim.notify(path)
        end,
        navigate_up_dir = function(state)
          local node = state.tree:get_node()
          local parent = node:get_parent_id()
          local util = require("neo-tree.utils")
          local loc = require("neo-tree.sources.filesystem")
          if parent ~= nil then
            local parent_path, _ = util.split_path(node:get_id())
            if parent_path == nil then
              return
            end
            loc.navigate(state, nil, parent_path)
          end
        end,
        open_term = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          if node.type ~= "directory" then
            local util = require("neo-tree.utils")
            path, _ = util.split_path(path)
          end
          local basedir = path
          if vim.env.TMUX ~= nil then
            pcall(vim.cmd, "silent !tmux split-window -c" .. basedir)
            return
          end
        end,
        dir_mark = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          if node.type ~= "directory" then
            local util = require("neo-tree.utils")
            path, _ = util.split_path(path)
          end
          local basedir = path
          vim.cmd("ZFDirDiffMark " .. basedir)
        end,
        diff_files = function(state)
          local node = state.tree:get_node()
          local log = require("neo-tree.log")
          state.clipboard = state.clipboard or {}
          if diff_Node and diff_Node ~= tostring(node.id) then
            local current_Diff = node.id
            require("neo-tree.utils").open_file(state, diff_Node, open)
            vim.cmd("vert diffs " .. current_Diff)
            log.info("Diffing " .. diff_Name .. " against " .. node.name)
            diff_Node = nil
            current_Diff = nil
            state.clipboard = {}
            require("neo-tree.ui.renderer").redraw(state)
          else
            local existing = state.clipboard[node.id]
            if existing and existing.action == "diff" then
              state.clipboard[node.id] = nil
              diff_Node = nil
              require("neo-tree.ui.renderer").redraw(state)
            else
              state.clipboard[node.id] = { action = "diff", node = node }
              diff_Name = state.clipboard[node.id].node.name
              diff_Node = tostring(state.clipboard[node.id].node.id)
              log.info("Diff source file " .. diff_Name)
              require("neo-tree.ui.renderer").redraw(state)
            end
          end
        end,
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        bind_to_cwd = true,
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,
        },
      },
    },
    keys = {
      -- { "<leader><tab>", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      { "<leader><tab>", "<cmd>Neotree toggle<cr>", desc = "Explorer NeoTree" },
      { "<leader>/", "<leader>sg", desc = "live_grep resent", remap = true },
      {
        "<leader>sg",
        function()
          local cwd = M.resentGrepFolder
          local opt = {}
          if cwd ~= nil then
            opt = vim.tbl_deep_extend("force", opt, { cwd = cwd })
            vim.notify("grep in:" .. opt.cwd)
          end
          require("telescope.builtin").live_grep(opt)
        end,
        desc = "grep in resent folder",
      },
      {
        "<leader>ff",
        function()
          local cwd = M.resentGrepFolder
          local opt = {}
          if cwd ~= nil then
            opt = vim.tbl_deep_extend("force", opt, { cwd = cwd })
            vim.notify("find file in:" .. opt.cwd)
          end
          require("telescope.builtin").find_files(opt)
        end,
        desc = "find file in resent folder",
      },
    },
  },
  -- dependencies = { "telescope.nvim" },
}
