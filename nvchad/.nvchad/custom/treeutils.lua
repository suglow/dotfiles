local lib = require 'nvim-tree.lib'
local openfile = require 'nvim-tree.actions.node.open-file'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
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
  diff_source = nil,
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


local view_selection = function(prompt_bufnr, map)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local filename = selection.filename
    if (filename == nil) then
      filename = selection[1]
    end
    local row = selection.row or selection.lnum
    local col = selection.col
    openfile.fn('edit', filename)

    vim.api.nvim_win_set_cursor(0, { row, col })
  end)
  return true
end

function M.launch_live_grep(opts)
  return M.launch_telescope("live_grep", opts)
end

function M.launch_find_files(opts)
  return M.launch_telescope("find_files", opts)
end

function M.launch_resent_find_files()
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
end

function M.launch_resent_live_grep()
  local opt = {}
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
end

function M.launch_live_grep_args()
  local telescope_status_ok, _ = pcall(require, "telescope")
  if not telescope_status_ok then
    return
  end
  local node = lib.get_node_at_cursor()
  local is_folder = node.fs_stat and node.fs_stat.type == 'directory' or false
  local basedir = is_folder and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
  if (node.name == '..' and TreeExplorer ~= nil) then
    basedir = TreeExplorer.absolute_path
  end
  local opts = {}
  opts.cwd = basedir
  opts.search_dirs = { basedir }
  opts.attach_mappings = view_selection
  opts.hiden = true
  opts.no_ignore = true
  vim.notify('basedir is ' .. basedir)
  M.resentFolders:push(basedir)
  require("telescope").extensions.live_grep_args.live_grep_args(opts)
end

function M.launch_telescope(func_name, opts)
  local telescope_status_ok, _ = pcall(require, "telescope")
  if not telescope_status_ok then
    return
  end
  local node = lib.get_node_at_cursor()
  local is_folder = node.fs_stat and node.fs_stat.type == 'directory' or false
  local basedir = is_folder and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
  if (node.name == '..' and TreeExplorer ~= nil) then
    basedir = TreeExplorer.absolute_path
  end
  opts = opts or {}
  if func_name == 'find_files' then
    opts.previewer = false
  end
  opts.cwd = basedir
  opts.search_dirs = { basedir }
  opts.attach_mappings = view_selection
  opts.hiden = true
  opts.no_ignore = true
  vim.notify('basedir is ' .. basedir)
  M.resentFolders:push(basedir)
  return require("telescope.builtin")[func_name](opts)
end

function M.toggle_term()
  local terminal_ok, terminal = pcall(require, "toggleterm.terminal")
  if not terminal_ok then
    return
  end
  -- toggleterm = require("toggleterm")
  -- local term_status_ok, toggleterm = pcall(require, "toggleterm")
  -- if not term_status_ok then
  --   return
  -- end
  local node = lib.get_node_at_cursor()
  local is_folder = node.fs_stat and node.fs_stat.type == 'directory' or false
  local basedir = is_folder and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
  if (node.name == '..' and TreeExplorer ~= nil) then
    basedir = TreeExplorer.absolute_path
  end
  -- print(basedir)
  -- terminal.Terminal:new():toggle(10, "horizontal")
  -- toggleterm.exec_command('cmd="cd '.. basedir ..'"')
  if vim.env.TMUX ~= nil then
    pcall(vim.cmd, "silent !tmux split-window -c" .. basedir)
    return
  end

  local term, created = terminal.get_or_create_term(terminal.get_toggled_id(), basedir, "horizontal")
  if not term:is_open() then term:open(15, "horizontal", created) end
  if not created then term:change_dir(basedir) end
end

function M.dir_mark()
  local node = lib.get_node_at_cursor()
  local is_folder = node.fs_stat and node.fs_stat.type == 'directory' or false
  local basedir = is_folder and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
  vim.cmd("ZFDirDiffMark " .. basedir)
end

function M.diff_files()
  local node = lib.get_node_at_cursor()
  local is_folder = node.fs_stat and node.fs_stat.type == 'directory' or false
  if is_folder then
    return
  end
  if M.diff_source == nil then
    M.diff_source = node.absolute_path
    vim.notify("diff source:" .. node.absolute_path)
  else
    openfile.fn('edit', M.diff_source)
    M.diff_source = nil
    vim.cmd("vert diffs " .. node.absolute_path)
  end
end
return M
