local status_ok, neogit = pcall(require, "neogit")
if not status_ok then
	return
end

neogit.setup(
  {
    integrations = {
      diffview = true,
    },
    mappings = {
      status = {
        ["<tab>"] = "",
        ["o"] = "Toggle",
      }
    },
  }
)
