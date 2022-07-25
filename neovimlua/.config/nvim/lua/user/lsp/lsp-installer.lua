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
  "rust_analyzer@nightly",
  "sumneko_lua",
  "gopls",
  "pyright",
  "yamlls",
  "bashls",
  "clangd",
}

local settings = {
  ensure_installed = servers,
  -- automatic_installation = false,
  ui = {
    icons = {},
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
}

lsp_installer.setup(settings)

for _, server in pairs(servers) do
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
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
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    -- opts = vim.tbl_deep_extend("force", require("lua-dev").setup(), opts)
    local luadev = lua_dev.setup {
      --   -- add any options here, or leave empty to use the default settings
      -- lspconfig = opts,
      library = {
        vimruntime = true, -- runtime path
        types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        plugins = true, -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as a workspace library
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
      },
      runtime_path = false, -- enable this to get completion in require strings. Slow!
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

  if server == "rust_analyzer" then
    local rust_opts = require "user.lsp.settings.rust"
    rusttools.setup(rust_opts)
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
        analyses = { unusedparams = true, unreachable = false },
        codelenses = {
          generate = true, -- show the `go generate` lens.
          gc_details = true, --  // Show a code lens toggling the display of gc's choices.
          test = true,
          tidy = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        matcher = 'fuzzy',
        diagnosticsDelay = '500ms',
        experimentalWatchedFileDelay = '1000ms',
        symbolMatcher = 'fuzzy',
      },
      lsp_gofumpt = true,
      lsp_keymaps = handlers.lsp_keymaps,
      -- lsp_on_attach = handlers.on_attach,

      dap_debug = true,
      dap_debug_gui = true,
      luasnip = true

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
