return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            -- Ctrl + \ to open
            open_mapping = [[<c-\>]], 

            hide_numbers = true, 
            start_in_insert = true,
            persist_mode = true, 
            direction = 'horizontal', 
            close_on_exit = true, 
            float_opts = {
                border = 'curved',
                winblend = 3,
            },
        })
    end
}
