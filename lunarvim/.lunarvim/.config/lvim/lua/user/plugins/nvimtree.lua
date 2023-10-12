local Util = require("user.treeutils")
return {
	{
		"kyazdani42/nvim-tree.lua",
    keys = {
			{ "<leader><tab>", "<cmd>NvimTreeToggle<CR>", desc = "Explorer NeoTree" },
      { "<leader>ff", Util.launch_resent_find_files, desc = "Find Recent Files" },
      { "<leader>sg", Util.launch_resent_live_grep, desc = "Live_grep Resent" },
      { "<leader>/", "<leader>sg", desc = "Live_grep Resent", remap = true },
		},
	},
}
