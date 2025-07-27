return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        local ls = require("luasnip")

        -- Load VSCode-style snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        -- Load custom Lua snippets
        require("luasnip.loaders.from_lua").load({
            paths = vim.fn.expand("~/.config/nvim/lua/plugins/snippets"),
        })

        -- Keybindings
        vim.keymap.set({ "i" }, "<C-l>", function()
            if ls.expand_or_jumpable() then
                ls.expand()
            end
        end, { silent = true })
        
        -- jump forwards
        vim.keymap.set({ "i", "s" }, "<C-k>", function()
            if ls.jumpable(1) then
                ls.jump(1)
            end
        end, { silent = true })
        
        -- jump backwards
        vim.keymap.set({ "i", "s" }, "<C-j>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<C-E>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, { silent = true })
    end,
}

