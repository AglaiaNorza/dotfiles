return {
    "max397574/better-escape.nvim",
    config = function()
        require("better_escape").setup({
            timeout = vim.o.timeoutlen,
            mappings = {
                i = {
                    j = {
                        j = '<Esc>'
                    },
                }

            }
        })
    end,
}
