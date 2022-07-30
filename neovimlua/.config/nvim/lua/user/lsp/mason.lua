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

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  if server == "jsonls" then
    local jsonls_opts = require "user.lsp.settings.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "sumneko_lua" then
    local l_status_ok, lua_dev = pcall(require, "lua-dev")
    if not l_status_ok then
      return
    end
    -- local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    -- opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    -- opts = vim.tbl_deep_extend("force", require("lua-dev").setup(), opts)
    local luadev = lua_dev.setup {
      --   -- add any options here, or leave empty to use the default settings
      -- lspconfig = opts,
      lspconfig = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        --   -- settings = opts.settings,
      },
    }
    lspconfig.sumneko_lua.setup(luadev)
    goto continue
  end


  if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

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

  if server == "rust_analyzer" then
    local rust_opts = require "user.lsp.settings.rust"
    -- opts = vim.tbl_deep_extend("force", rust_opts, opts)
    local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_status_ok then
      return
    end

    rust_tools.setup(rust_opts)
    goto continue
  end

  lspconfig[server].setup(opts)
  ::continue::
end
