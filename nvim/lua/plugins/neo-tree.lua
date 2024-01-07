return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = { "Neotree" },
	keys = {
		{ "<F8>", "<cmd>Neotree toggle reveal<cr>", desc = "Toggle tree sidebar" },
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			source_selector = {
				winbar = true,
				statusline = false,
			},
		})
	end,
}
