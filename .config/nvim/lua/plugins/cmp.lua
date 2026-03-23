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
            -- 'hrsh7th/cmp-vsnip',
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

            local kind_icons = {
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰊄",
            }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- Only use LuaSnip
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        -- Put the icon and the name of the kind together
                        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or "", vim_item.kind)
                        
                        -- Add a tag showing where the completion came from
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            path = "[Path]",
                        })[entry.source.name]
                        
                        return vim_item
                    end,
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
                    { name = 'nvim_lsp', priority = 1000 }, 
                    { name = 'luasnip',  priority = 750 },  
                    { name = 'path',     priority = 500 },                  
                })
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
        end,
    },
}

