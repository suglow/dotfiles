local lib = require 'nvim-tree.lib'
local openfile = require 'nvim-tree.actions.node.open-file'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local M = {}

local view_selection = function(prompt_bufnr, map)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local filename = selection.filename
    if (filename == nil) then
      filename = selection[1]
    end
    openfile.fn('preview', filename)
  end)
  return true
end

function M.launch_live_grep(opts)
  return M.launch_telescope("live_grep", opts)
end

function M.launch_find_files(opts)
  return M.launch_telescope("find_files", opts)
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
    basedir = TreeExplorer.cwd
  end
  local opts = {}
  opts.cwd = basedir
  opts.search_dirs = { basedir }
  -- opts.attach_mappings = view_selection
  opts.hiden = true
  opts.no_ignore = true
  vim.notify('basedir is '..basedir)
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
    basedir = TreeExplorer.cwd
  end
  opts = opts or {}
  opts.cwd = basedir
  opts.search_dirs = { basedir }
  -- opts.attach_mappings = view_selection
  opts.hiden = true
  opts.no_ignore = true
  vim.notify('basedir is '..basedir)
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
    basedir = TreeExplorer.cwd
  end
  -- print(basedir)
  -- terminal.Terminal:new():toggle(10, "horizontal")
  -- toggleterm.exec_command('cmd="cd '.. basedir ..'"')
  local term, created = terminal.get_or_create_term(terminal.get_toggled_id(), basedir, "horizontal")
  if not term:is_open() then term:open(15, "horizontal" ,created) end
  if not created  then term:change_dir(basedir) end
end

return M
