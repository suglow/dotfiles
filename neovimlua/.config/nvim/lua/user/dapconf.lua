
local dap_virt_status_ok, dap_virt = pcall(require, "nvim-dap-virtual-text")
if not dap_virt_status_ok then
	return
end

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end
dap_virt.setup()

dapui.setup()

-- dapui.setup {
--   icons = { expanded = "▾", collapsed = "▸" },
--   mappings = {
--     -- Use a table to apply multiple mappings
--     expand = { "<CR>", "<2-LeftMouse>" },
--     open = "o",
--     remove = "d",
--     edit = "e",
--     repl = "r",
--     toggle = "t",
--   },
--   sidebar = {
--     -- You can change the order of elements in the sidebar
--     elements = {
--       -- Provide as ID strings or tables with "id" and "size" keys
--       {
--         id = "scopes",
--         size = 0.25, -- Can be float or integer > 1
--       },
--       { id = "breakpoints", size = 0.25 },
--       -- { id = "stacks", size = 0.25 },
--       -- { id = "watches", size = 00.25 },
--     },
--     size = 40,
--     position = "right", -- Can be "left", "right", "top", "bottom"
--   },
--   tray = {
--     elements = {},
--     -- elements = { "repl" },
--     -- size = 10,
--     -- position = "bottom", -- Can be "left", "right", "top", "bottom"
--   },
--   floating = {
--     max_height = nil, -- These can be integers or a float between 0 and 1.
--     max_width = nil, -- Floats will be treated as percentage of your screen.
--     border = "rounded", -- Border style. Can be "single", "double" or "rounded"
--     mappings = {
--       close = { "q", "<Esc>" },
--     },
--   },
--   windows = { indent = 1 },
-- }
local icons = require "user.icons"

vim.fn.sign_define('DapBreakpoint', {text=icons.ui.Bug, texthl='DiagnosticSignError', linehl='', numhl=''})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- 加载调试器配置
local dap_config = {
    python = require("user.dap.python"),
}
-- 设置调试器
for dap_name, dap_options in pairs(dap_config) do
    dap.adapters[dap_name] = dap_options.adapters
    dap.configurations[dap_name] = dap_options.configurations
end

local adapter_lldb     = require("user.dap.cpprust").adapters
local adapter_codelldb = require("user.dap.codelldb").adapters
local adapter_cpptools = require("user.dap.cpptools").adapters
-- local config_lldb      = require("user.dap.cpprust").configurations
local config_codelldb  = require("user.dap.codelldb").configurations
local config_cpptools  = require("user.dap.cpptools").configurations

dap.adapters.lldb       = adapter_lldb
dap.adapters.codelldb   = adapter_codelldb
dap.adapters.cppdbg     = adapter_cpptools
dap.configurations.rust = config_codelldb
dap.configurations.c    = config_cpptools
dap.configurations.cpp  = config_cpptools

