return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim"
		},
		keys = {
			{"<leader>ts", function() require("neotest").summary.toggle({ enter = true }) end, desc="Toggle neotest sidebar" },
			{ "<leader>fi", function() require("neotest").run.run(vim.fn.expand("%"))  end, desc="Run all tests in this file" },
			{ "<leader>fu", function() require("neotest").run.run() end, desc="Run the current function" },
			{ "<leader>fd", function() require("neotest").run.run({strategy = "dap"})  end, desc="Debug the current function" },
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python")({
						runner = "pytest",
						args = { "-s" },
					})
				},
				floating = {
					max_height = 0.8,
					max_width = 0.8,
				},
				strategies = {
					integrated = {
						width = 180
					}
				},
			})
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
		end
	},
	{
		"nvim-neotest/neotest-python",
	},
}
