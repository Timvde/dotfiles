return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		"AckslD/nvim-neoclip.lua",
	},
	cmd = { "Telescope" },
	keys = {
		{ "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
		{ "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Find buffer" },
		{ "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
		{ "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Search vim help" },
		{ "<leader>ft", function() require("telescope.builtin").tags() end, desc = "Find symbols" },
		{ "<F5>", function() require("telescope").extensions.undo.undo() end, desc = "Show undo tree" },
		{ "<F6>", function() require("telescope").extensions.neoclip.neoclip() end, desc = "Toggle clipboard history" },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				layout_config = {
					horizontal = { preview_width = 0.5 },
				}
			},
			extensions = {
				undo = {
					mappings = {
						i = {
							["<s-cr>"] = require("telescope-undo.actions").yank_additions,
							["<c-cr>"] = require("telescope-undo.actions").yank_deletions,
							["<cr>"] = require("telescope-undo.actions").restore
						},
					},
					layout_config = {
						preview_width = 0.8
					},
				},
				neoclip = {},
			},
		})
		require("telescope").load_extension("undo")
		require("telescope").load_extension("neoclip")
		require("neoclip").setup()
	end,
}
