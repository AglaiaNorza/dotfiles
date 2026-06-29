return
{
    'Julian/lean.nvim',
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'andymass/vim-matchup', 
    },
    init = function()
      -- The new standard way to configure lean.nvim
      vim.g.lean_config = {
        mappings = true,
        lsp = {
          enable = true,
        },
        infoview = {
          autoopen = true,
          width = 50,
          placement = "right",
        }
      }
    end,
  }



