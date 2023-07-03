return {
	{
		"nvim-tree/nvim-tree.lua",
		opts = function(_, opts)
			local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
			if not config_status_ok then
				return
			end

			local tree_cb = nvim_tree_config.nvim_tree_callback

			local function custom_callback(callback_name)
				return string.format("<cmd>lua require('custom.treeutils').%s()<CR>", callback_name)
			end

			local function on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				api.config.mappings.default_on_attach(bufnr)

				-- Mappings migrated from view.mappings.list
				--
				-- You will need to insert "your code goes here" for any mappings with a custom action_cb
				vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))

				--[[ { key = "<c-f>", cb = custom_callback "launch_find_files" }, ]]
				--[[ { key = "<c-g>", cb = custom_callback "launch_live_grep" }, ]]
				--[[ { key = "<c-d>", cb = custom_callback "launch_live_grep_args" }, ]]
				--[[ { key = "T", cb = custom_callback "toggle_term" }, ]]
				--[[ { key = "<c-t>", cb = custom_callback "toggle_term" }, ]]
				vim.keymap.set("n", "<c-f>", function()
					require("custom.treeutils").launch_find_files()
				end, opts("Find files"))
				vim.keymap.set("n", "<c-g>", function()
					require("custom.treeutils").launch_live_grep()
				end, opts("Live Grep"))
				vim.keymap.set("n", "<c-d>", function()
					require("custom.treeutils").launch_live_grep_args()
				end, opts("Live Grep Directry"))
				vim.keymap.set("n", "<c-t>", function()
					require("custom.treeutils").toggle_term()
				end, opts("Toggle Term"))
			end

			local setup = {
				on_attach = on_attach,
				disable_netrw = true,
				hijack_netrw = true,
				open_on_tab = false,
				hijack_cursor = true,
				update_cwd = false,
				prefer_startup_root = false,
				sync_root_with_cwd = false,
				respect_buf_cwd = false,
				hijack_directories = {
					enable = false,
					auto_open = false,
				},
				diagnostics = {
					enable = true,
					icons = {
						hint = "",
						info = "",
						warning = "",
						error = "",
					},
				},
				update_focused_file = {
					enable = true,
					update_cwd = false,
					update_root = false,
					ignore_list = {},
				},
				system_open = {
					cmd = nil,
					args = {},
				},
				filters = {
					dotfiles = false,
					custom = {},
				},
				renderer = {
					icons = {
						glyphs = {
							default = "",
							symlink = "",
							git = {
								unstaged = "",
								staged = "S",
								unmerged = "",
								renamed = "➜",
								deleted = "",
								untracked = "U",
								ignored = "◌",
							},
							folder = {
								default = "",
								open = "",
								empty = "",
								empty_open = "",
								symlink = "",
							},
						},
					},
				},
				git = {
					enable = true,
					show_on_dirs = false,
					show_on_open_dirs = false,
					ignore = true,
					timeout = 500,
				},
				view = {
					width = 45,
					hide_root_folder = false,
					side = "left",
					mappings = {
						custom_only = false,
						list = {
							{ key = { "<CR>", "o" }, cb = tree_cb("edit") },
							-- { key = "h", cb = tree_cb "close_node" },
							{ key = "v", cb = tree_cb("vsplit") },
							{ key = "<c-f>", cb = custom_callback("launch_find_files") },
							{ key = "<c-g>", cb = custom_callback("launch_live_grep") },
							{ key = "<c-d>", cb = custom_callback("launch_live_grep_args") },
							{ key = "T", cb = custom_callback("toggle_term") },
							{ key = "<c-t>", cb = custom_callback("toggle_term") },
						},
					},
					number = false,
					relativenumber = false,
				},
				trash = {
					cmd = "trash",
					require_confirm = true,
				},
				actions = {
					use_system_clipboard = true,
					change_dir = {
						enable = true,
						global = false,
						restrict_above_cwd = false,
					},
					open_file = {
						quit_on_open = false,
						resize_window = true,
						window_picker = {
							enable = true,
							chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
							exclude = {
								filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
								buftype = { "nofile", "terminal", "help" },
							},
						},
					},
				},
			}
			setup = vim.tbl_deep_extend("force", opts, setup)
			return setup
		end,
		keys = {
			{ "<leader><tab>", "<cmd>NvimTreeToggle<CR>", desc = "Explorer NeoTree" },
		},
	},
}
