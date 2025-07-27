--tokyonight
return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function() --automatically calls require(MAIN).setup
		vim.cmd.colorscheme "tokyonight-night" 
	end
}
