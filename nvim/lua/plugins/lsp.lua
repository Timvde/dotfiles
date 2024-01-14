return {
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			"mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function()
			local lsp = require('lsp-zero').preset({
				name = "recommended",
				set_lsp_keymaps = {
					omit = { "gs" },
				}
			})
			local lspconfig = require('lspconfig')
			local cmp = require('cmp')

			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
				vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = true})
			end)

			-- Configure lua language server for neovim
			lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

			lsp.setup()

			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				mapping = {
					['<C-Space>'] = cmp.mapping.complete(),

					["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
							-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
							-- they way you will only jump inside the snippet region
							-- elseif luasnip.expand_or_jumpable() then
							-- 	luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
						end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
							-- elseif luasnip.jumpable(-1) then
							-- 	luasnip.jump(-1)
						else
							fallback()
						end
						end, { "i", "s" }),
				},
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lsp_signature_help' },
					{ name = 'path', keyword_length = 3 },
					{ name = 'buffer', keyword_length = 3 },
				},
			})
		end,
		manage_nvim_cmp = {
			set_basic_mappings = true,
			set_extra_mappings = false,
			-- use_luasnip = true,
			set_format = true,
			documentation_window = true,
		}
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"jedi_language_server",
					"jsonls",
				}
			})
		end
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			null_ls.setup({
				-- you can reuse a shared lspconfig on_attach callback here
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			})
			require("mason-null-ls").setup({
				ensure_installed = {
					"jq",
					"xmlformatter",
					"flake8",
					"black",
					"isort",
				},
				handlers = {}
			})
		end,
	}
}
