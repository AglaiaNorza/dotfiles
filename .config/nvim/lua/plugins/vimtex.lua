return {
  "lervag/vimtex",
  lazy = false, 
  -- tag = "v2.15", 
  init = function()
        vim.g.vimtex_view_method = "zathura"

        --vim.g.vimtex_view_general_viewer = 'okular'
        --vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'


        vim.g.vimtex_quickfix_open_on_warning = 0
        vim.g.vimtex_quickfix_open_on_error = 1
    end,
    config = function()
        vim.cmd("filetype plugin indent on")
        vim.cmd("syntax enable")
    end
}
