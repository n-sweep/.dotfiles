vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 1999
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'
vim.opt.mouse = ''
vim.opt.wrap = false
vim.opt.errorbells = false
vim.opt.termguicolors = true

-- Allow formatting of long lines with "gq".
vim.opt.formatoptions:append('q')