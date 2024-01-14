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
			local dapui = require("dapui")
			dapui.setup()
			local dap = require("dap")
			local debug_win = nil
			local debug_tab = nil
			local debug_tabnr = nil

			local function open_in_tab()
				if debug_win and vim.api.nvim_win_is_valid(debug_win) then
					vim.api.nvim_set_current_win(debug_win)
					return
				end

				vim.cmd('tabedit %')
				debug_win = vim.fn.win_getid()
				debug_tab = vim.api.nvim_win_get_tabpage(debug_win)
				debug_tabnr = vim.api.nvim_tabpage_get_number(debug_tab)

				dapui.open()
			end

			local function close_tab()
				dapui.close()

				if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
					vim.api.nvim_exec('tabclose ' .. debug_tabnr, false)
				end

				debug_win = nil
				debug_tab = nil
				debug_tabnr = nil
			end

			-- Attach DAP UI to DAP events
			dap.listeners.after.event_initialized['dapui_config'] = function()
				open_in_tab()
			end
			dap.listeners.before.event_terminated['dapui_config'] = function()
				close_tab()
			end
			dap.listeners.before.event_exited['dapui_config'] = function()
				close_tab()
			end
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
