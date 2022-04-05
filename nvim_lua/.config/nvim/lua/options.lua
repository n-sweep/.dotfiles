-- Aliases
local opt = vim.opt
local g = vim.g

-- Options
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
