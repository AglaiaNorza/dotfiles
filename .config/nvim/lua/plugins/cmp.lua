return {
    {
        'neovim/nvim-lspconfig',
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            --'hrsh7th/cmp-vsnip',
            --'hrsh7th/vim-vsnip',
            'saadparwaiz1/cmp_luasnip',
            -- 'SirVer/ultisnips',
            -- 'quangnguyen30192/cmp-nvim-ultisnips',
            -- 'dcampos/nvim-snippy',
            -- 'dcampos/cmp-snippy',
            -- 'echasnovski/mini.snippets',
            -- 'abeldekat/cmp-mini-snippets',
        },
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body) -- For vsnip users.
                        require('luasnip').lsp_expand(args.body) -- For luasnip users.

                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    --['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- "Enter" confirms selection
                    ['<Space>'] = cmp.mapping.confirm({select = false}), -- "Space" confirms selection
                    -- CTRL+Space confirms selection and, if nothing is selected, chooses the first option
                    ["<C-Space>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif require("luasnip").expand_or_jumpable() then
                            require("luasnip").expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif require("luasnip").jumpable(-1) then
                            require("luasnip").jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' },
                    { name = 'luasnip' },
                    -- { name = 'ultisnips' },
                    -- { name = 'snippy' },
                }, {
                        { name = 'buffer' },
                        {name = 'path'},
                    }),
            })

            -- Use buffer source for '/' and '?' in cmdline
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':'
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                        { name = 'cmdline' }
                    }),
                matching = { disallow_symbol_nonprefix_matching = false },
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local servers = { "pyright", "clangd", "lua_ls" }
            for _, server in ipairs(servers) do
                vim.lsp.config(server, {
                    capabilities = capabilities,
                })
            end

            -- Enable them all in one go
            vim.lsp.enable(servers)

        end,
    },
}

