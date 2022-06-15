local status_ok, rusttools = pcall(require, "rust-tools")
if not status_ok then
	return
end

local status_ok, handlers = pcall(require, "user.lsp.handlers")
if not status_ok then
	return
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- -- snippets
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
--
-- -- send actions with hover request
-- capabilities.experimental = {
--   hoverActions = true,
--   hoverRange = true,
--   serverStatusNotification = true,
--   snippetTextEdit = true,
--   codeActionGroup = true,
--   ssr = true,
-- }
--
-- -- enable auto-import
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = { "documentation", "detail", "additionalTextEdits" },
-- }
--
-- -- rust analyzer goodies
-- capabilities.experimental.commands = {
--   commands = {
--     "rust-analyzer.runSingle",
--     "rust-analyzer.debugSingle",
--     "rust-analyzer.showReferences",
--     "rust-analyzer.gotoLocation",
--     "editor.action.triggerParameterHints",
--   },
-- }
--
local capabilities =  {
  textDocument = {
    completion = {
      completionItem ={}
    }
  }
}
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

capabilities = cmp_nvim_lsp.update_capabilities(capabilities)


local extension_path = os.getenv( "HOME" ) .. "/.local/bin/codelldb/extension/" 
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local opts = {
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
    capabilities = capabilities,
    on_attach = handlers.on_attach,
	}, -- rust-analyer options
  dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter(
          codelldb_path, liblldb_path),
  }
}

rusttools.setup(opts)
