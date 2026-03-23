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
                ensure_installed = { "lua_ls", "jdtls", "pyright", "clangd", "hls" },
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("lua_ls", { capabilities = capabilities })
            vim.lsp.config("jdtls", { capabilities = capabilities })
            vim.lsp.config("pyright", { capabilities = capabilities })
            vim.lsp.config("hls", { capabilities = capabilities })

            vim.lsp.config("clangd", {
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                },
                init_options = {
                    fallbackFlags = { "-std=c++20" },
                },
            })

            vim.lsp.enable({ "lua_ls", "pyright", "clangd", "hls"})

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                    end
                end,
            })

            --keymaps 
            vim.keymap.set("n", "H", vim.lsp.buf.hover, {}) --hover over code 
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {}) --definition 
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {}) --code actions 
        end,
    },
}
