local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

local servers = {
  "jsonls",
  "sumneko_lua",
  "pyright",
  "yamlls",
  "bashls",
  "clangd",
  "rust_analyzer",
  "gopls",
}

-- local settings = {
--   ui = {
--     border = "rounded",
--     icons = {
--       package_installed = "◍",
--       package_pending = "◍",
--       package_uninstalled = "◍",
--     },
--   },
--   log_level = vim.log.levels.INFO,
--   max_concurrent_installers = 4,
-- }

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end
-- mason.setup(settings)
mason.setup({})

local common_opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}
mason_lspconfig.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {}
  end,
  ["jsonls"] = function()
    local jsonls_opts = require "user.lsp.settings.jsonls"
    local opts = vim.tbl_deep_extend("force", jsonls_opts, common_opts)
    lspconfig["jsonls"].setup(opts)
  end,
  ["sumneko_lua"] = function()
    local _, lua_dev = pcall(require, "lua-dev")
    local luadev = lua_dev.setup {
      lspconfig = {
        on_attach = common_opts.on_attach,
        capabilities = common_opts.capabilities,
        --   -- settings = opts.settings,
      },
    }
    lspconfig["sumneko_lua"].setup(luadev)
  end,
  ["pyright"] = function()
    local pyright_opts = require "user.lsp.settings.pyright"
    local opts = vim.tbl_deep_extend("force", pyright_opts, common_opts)
    lspconfig["pyright"].setup(opts)
  end,
  ["rust_analyzer"] = function()
    local rust_opts = require "user.lsp.settings.rust"
    local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_status_ok then
      return
    end
    rust_tools.setup(rust_opts)
  end
}



--  if server == "gopls" then
--    local path = require 'mason.core.path'
--    local install_root_dir = path.concat { vim.fn.stdpath 'data', 'lsp_servers' }
--    require 'go'.setup({
--      gopls_cmd = { install_root_dir .. '/gopls/gopls' },
--      fillstruct = 'gopls',
--      lsp_cfg = {
--        capabilities = handlers.capabilities,
--        analyses = { unusedparams = true, unreachable = false },
--        codelenses = {
--          generate = true, -- show the `go generate` lens.
--          gc_details = true, --  // Show a code lens toggling the display of gc's choices.
--          test = true,
--          tidy = true,
--        },
--        usePlaceholders = true,
--        completeUnimported = true,
--        staticcheck = true,
--        matcher = 'fuzzy',
--        diagnosticsDelay = '500ms',
--        experimentalWatchedFileDelay = '1000ms',
--        symbolMatcher = 'fuzzy',
--      },
--      lsp_gofumpt = true,
--      lsp_keymaps = handlers.lsp_keymaps,
--      -- lsp_on_attach = handlers.on_attach,
--
--      dap_debug = true,
--      dap_debug_gui = true,
--      luasnip = true
--
--    })
--    goto continue
--  end
