return {
	"max397574/better-escape.nvim",
	config = function()
		require("better_escape").setup({
            timeout = vim.o.timeoutlen,
            mappings = {
                j = {
                    j = '<Esc>'
                },
            }
		})
	end,
}
