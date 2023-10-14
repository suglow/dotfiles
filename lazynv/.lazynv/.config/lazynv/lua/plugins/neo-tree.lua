local LRUCacheStack = {}
LRUCacheStack.__index = LRUCacheStack

function LRUCacheStack:new()
  local stack = {
    stack = {},
    nodes = {},
  }
  setmetatable(stack, self)
  return stack
end

-- 向栈中添加一个元素
function LRUCacheStack:push(value)
  if self.nodes[value] then
    self:move_to_top(value)
  else
    table.insert(self.stack, 1, value)
    self.nodes[value] = 1
  end
end

-- 将一个节点移动到栈顶
function LRUCacheStack:move_to_top(value)
  for i = 1, #self.stack do
    if self.stack[i] == value then
      table.remove(self.stack, i)
      break
    end
  end
  table.insert(self.stack, 1, value)
end

-- 从栈中删除一个元素
function LRUCacheStack:pop()
  if #self.stack > 0 then
    local value = table.remove(self.stack, 1)
    self.nodes[value] = nil
    return value
  else
    return nil
  end
end

-- 获取栈顶元素
function LRUCacheStack:top()
  if #self.stack > 0 then
    return self.stack[1]
  else
    return nil
  end
end

-- 打印栈中所有元素
function LRUCacheStack:print()
  for i = 1, #self.stack do
    print(self.stack[i])
  end
end

function LRUCacheStack:get_all()
  local all = {}
  for i = 1, #self.stack do
    table.insert(all, self.stack[i])
  end
  return all
end

local M = {
  resentFolders = LRUCacheStack:new(),
}

function DirSelect(on_select)
  local folders = M.resentFolders:get_all()
  if #folders == 0 then
    on_select(true)
  else
    vim.ui.select(folders, {
      prompt = "resent Dirs",
      -- telescope = require("telescope.themes").get_cursor(),
    }, function(selected)
      on_select(selected)
    end)
  end
end

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
          M.resentFolders:push(path)
          -- vim.notify(vim.inspect(M.resentFolders:get_all()))
          require("telescope.builtin").find_files(getTelescopeOpts(state, path))
        end,
        telescope_grep = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          M.resentFolders:push(path)
          -- vim.notify(vim.inspect(M.resentFolders:get_all()))
          require("telescope.builtin").live_grep(getGrepTelescopeOpts(state, path))
        end,
        telescope_grep_args = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          M.resentFolders:push(path)
          -- vim.notify(vim.inspect(M.resentFolders:get_all()))
          require("telescope").extensions.live_grep_args.live_grep_args(getGrepTelescopeOpts(state, path))
        end,
        telescope_find_file = function(state)
          local path = require("lazyvim.util").get_root()
          M.resentFolders:push(path)
          -- vim.notify(vim.inspect(M.resentFolders:get_all()))
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
      { "<leader>/", "<leader>sg", desc = "live_grep resent", mode = { "n", "v" }, remap = true },
      -- { "<leader><space>", "<leader>ff", desc = "find file resent", remap = true},
      {
        "<leader>sg",
        function()
          local buf_vtext = function()
            local mode = vim.fn.mode()
            if mode ~= "v" then
              return ""
            end
            local a_orig = vim.fn.getreg("a")
            vim.cmd([[silent! normal! "aygv]])
            local text = vim.fn.getreg("a")
            vim.fn.setreg("a", a_orig)
            return text
          end

          -- local mode = vim.fn.mode()
          local cword = buf_vtext()
          local opt = {
            default_text = cword,
          }
          DirSelect(function(selected)
            if selected == nil then
              return
            end
            if selected ~= true then
              opt = vim.tbl_deep_extend("force", opt, { cwd = selected })
              vim.notify("grep in:" .. opt.cwd)
            end
            require("telescope.builtin").live_grep(opt)
          end)
        end,
        mode = { "n", "v" },
        desc = "grep in resent folder",
      },
      {
        "<leader>ff",
        function()
          local opt = {}
          DirSelect(function(selected)
            if selected == nil then
              return
            end
            if selected ~= true then
              opt = vim.tbl_deep_extend("force", opt, { cwd = selected })
              vim.notify("grep in:" .. opt.cwd)
            end
            require("telescope.builtin").find_files(opt)
          end)
        end,
        desc = "find file in resent folder",
      },
    },
  },
  -- dependencies = { "dressing.nvim" },
}
