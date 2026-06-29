return {

    'andymass/vim-matchup',
    event = 'BufReadPost',
    config = function()
      -- highlights the matching word under your cursor
      vim.g.matchup_matchparen_enabled = 1
      
       vim.g.matchup_matchparen_deferred = 1
    end
}
