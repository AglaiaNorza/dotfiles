vim.g.mapleader = ","
vim.g.localleader = ","
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true })
--line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4 --tabs: 4 spaces
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4 --for indentation
vim.opt.expandtab = true --spaces instead of tabs

vim.opt.wrap = true --if a line doesnt fit it "splits" it

vim.opt.incsearch = true --highlighting for searches

vim.opt.termguicolors = true

vim.opt.scrolloff = 8 --never has less than 8 lines before end of page

-- Better searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Sync with system clipboard
vim.opt.clipboard = "unnamedplus"

-- Faster completion and responsiveness (default is 4000ms)
vim.opt.updatetime = 250

-- clear search highlights on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
