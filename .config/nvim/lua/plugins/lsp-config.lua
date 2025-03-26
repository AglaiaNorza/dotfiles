--to add new server, add it in the ensure_installed and in the lspconfig

return {

	{
		"williamboman/mason.nvim",

		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",

		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "jdtls", "pyright", "clangd" },
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.jdtls.setup({})
			lspconfig.pyright.setup({})
            lspconfig.clangd.setup({})

			--keymaps
			vim.keymap.set("n", "H", vim.lsp.buf.hover, {}) --hover over code
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {}) --definition
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {}) --code actions
		end,
	},
}
