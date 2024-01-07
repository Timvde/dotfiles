return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		keys = {
			{ "<leader>dap", function() require("dapui").toggle({ reset = true }) end, desc="Toggle debugging UI" },
			{ "<leader>b", function() require("dap").toggle_breakpoint() end },
			{ "<leader>cb", ":lua require('dap').toggle_breakpoint('')" },
			{ "<leader>di", function() require("dap").step_into() end },
			{ "<leader>do", function() require("dap").step_over() end },
			{ "<leader>dc", function() require("dap").continue() end },
		},
		config = function()
			require("dapui").setup()
		end
	},
	{
		"mfussenegger/nvim-dap-python",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			local dap_python = require('dap-python')
			dap_python.setup()
			dap_python.test_runner = "pytest"
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"mason.nvim",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"python",
				}
			})
		end
	},
}
