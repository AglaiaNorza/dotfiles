return {
  "lervag/vimtex",
  lazy = false, 
  init = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_quickfix_open_on_warning = 0
        vim.g.vimtex_quickfix_open_on_error = 1
        vim.g.tex_flavor = 'latex'

        vim.g.tex_conceal = 'abdmg'
    end,
    config = function()
        vim.cmd("filetype plugin indent on")
        vim.cmd("syntax enable")
        
        vim.opt.conceallevel = 1
    end
}
