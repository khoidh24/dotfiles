return {
	-- Mason - Package manager for Language servers, DAP servers, Linters and Formatters
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason LSP - ensure install what you want
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"html",
					"cssls",
					"tailwindcss",
					"emmet_ls",
					"jsonls",
				},
				automatic_installation = true,
			})
		end,
	},

	-- Nvim-lsp - config your languages
	{
		"neovim/nvim-lspconfig",
		opts = {
			autoformat = true,
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				init_options = {
					preferences = {
						importModuleSpecifierPreference = "non-relative", -- Dùng import ES Modules
						importModuleSpecifierEnding = "minimal",
					},
				},
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})
			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, {})
		end,
	},

	-- Treesitter - Parse and highlight your languages
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				highlight = { enable = true, use_languagetree = true },
				indent = { enable = true },
				ensure_installed = {
					"html",
					"css",
					"lua",
					"json",
					"markdown",
					"javascript",
					"typescript",
					"tsx",
					"json",
					"http",
					"go",
				},
			})
		end,
	},
}
