return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	config = function()
		require("neo-tree").setup({
			close_if_last_window = false,
		})
		--keymaps
		vim.keymap.set("n", "<leader>n", ":Neotree filesystem reveal left<CR>")
	end,
}
