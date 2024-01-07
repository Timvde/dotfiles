return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = function() vim.cmd.TSUpdate() end,
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua", "python" },
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
					},
				},
			},
		})
	end,
}
