local status_ok, rusttools = pcall(require, "rust-tools")
if not status_ok then
	return
end

local status_ok, handlers = pcall(require, "user.lsp.handlers")
if not status_ok then
	return
end
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
    on_attach = handlers.on_attach;

	} -- rust-analyer options
}

rusttools.setup(opts)
