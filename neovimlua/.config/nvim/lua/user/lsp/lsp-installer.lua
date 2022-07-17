local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local hdl_status_ok, handlers = pcall(require, "user.lsp.handlers")
if not hdl_status_ok then
  return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local rust_status_ok, rusttools = pcall(require, "rust-tools")
if not rust_status_ok then
  return
end


local servers = {
  -- "cssls",
  -- "cssmodules_ls",
  -- "emmet_ls",
  -- "html",
  -- "jdtls",
  --  "jsonls",
  -- "solc",
  "rust_analyzer",
  "sumneko_lua",
  "gopls",
  -- "tflint",
  -- "tsserver",
  "pyright",
  "yamlls",
  "bashls",
  "clangd",
}

local settings = {
  ensure_installed = servers,
  -- automatic_installation = false,
  ui = {
    icons = {
      -- server_installed = "◍",
      -- server_pending = "◍",
      -- server_uninstalled = "◍",
      -- server_installed = "✓",
      -- server_pending = "➜",
      -- server_uninstalled = "✗",
    },
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
    },
  },

  log_level = vim.log.levels.INFO,
  -- max_concurrent_installers = 4,
  -- install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" },
}

lsp_installer.setup(settings)


local extension_path = os.getenv("HOME") .. "/.local/bin/codelldb/extension/"
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local opts_rust = {
  server = {
    -- standalone file support
    -- setting it to false may improve startup time
    -- standalone = true,
    ["rust-analyzer"] = {
      -- enable clippy on save
      checkOnSave = {
        command = "clippy"
      }
    },
    capabilities = handlers.capabilities,
    on_attach = handlers.on_attach,
  }, -- rust-analyzer options
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(
      codelldb_path, liblldb_path),
  }
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }

  if server == "jsonls" then
    local jsonls_opts = require "user.lsp.settings.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "sumneko_lua" then
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "rust-analyzer" then
    rusttools.setup(opts_rust)
    goto continue
  end

  if server == "gopls" then
    local path = require 'nvim-lsp-installer.core.path'
    local install_root_dir = path.concat { vim.fn.stdpath 'data', 'lsp_servers' }
    require 'go'.setup({
      gopls_cmd = { install_root_dir .. '/gopls/gopls' },
      fillstruct = 'gopls',
      lsp_cfg = {
        capabilities = handlers.capabilities,
      },
      lsp_gofumpt = true,
      lsp_keymaps = false,
      lsp_on_attach = handlers.on_attach,

      dap_debug = true,
      dap_debug_gui = true
    })
    goto continue
  end
  -- if server == "solang" then
  --   local solang_opts = require "user.lsp.settings.solang"
  --   opts = vim.tbl_deep_extend("force", solang_opts, opts)
  -- end
  --
  -- if server == "solc" then
  --   local solc_opts = require "user.lsp.settings.solc"
  --   opts = vim.tbl_deep_extend("force", solc_opts, opts)
  -- end
  --
  -- if server == "emmet_ls" then
  --   local emmet_ls_opts = require "user.lsp.settings.emmet_ls"
  --   opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  -- end

  lspconfig[server].setup(opts)
  ::continue::
end
