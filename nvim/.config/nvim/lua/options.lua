-- Aliases
local opt = vim.opt
local g = vim.g

-- Options
opt.colorcolumn = '80'
opt.completeopt = 'menu'
opt.errorbells = false
opt.expandtab = true
opt.hlsearch = false
opt.number = true
opt.relativenumber = true
opt.scrolloff = 1999
opt.shiftwidth = 4
opt.signcolumn = 'yes'
opt.softtabstop = 4
opt.swapfile = false
opt.tabstop = 4
opt.wrap = false

-- Set Leader
g.mapleader = ' '

-- Netrw Settings
g.netrw_banner = 0
g.netrw_liststyle = 3

-- Use system slipboard (WSL)
opt.clipboard = 'unnamedplus'

-- Undo file
local dir = "/tmp/.vim-undo-dir"
if not vim.fn.isdirectory(dir)
    then vim.fn.mkdir(dir, '', 0700)
end
opt.undodir = dir
opt.undofile = true

-- Screen tearing fix (?)
vim.api.nvim_command('autocmd BufEnter * highlight Normal guibg=0')
