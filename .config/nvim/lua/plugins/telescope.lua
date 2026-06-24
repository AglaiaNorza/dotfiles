return {

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },

        config = function()
            local builtin = require("telescope.builtin")

            -- keymaps
            vim.keymap.set('n', '<leader>p', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {}) -- switch between open buffers
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {}) -- search help docs
        end
    },

    {
        'nvim-telescope/telescope-ui-select.nvim', --prettier ui select (for code actions and stuff)

        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            })
            require("telescope").load_extension("ui-select")
        end
    },

}
