local opt = vim.opt

vim.g.mapleader = " "

-- wtf? addendum: this rules
opt.inccommand = "split"

opt.number = true
opt.relativenumber = true
opt.cursorline = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.incsearch = true

opt.conceallevel = 1
opt.scrolloff = 1999
opt.signcolumn = 'yes'
opt.colorcolumn = '100'
opt.mouse = ''
opt.wrap = false
opt.errorbells = false
opt.termguicolors = true

-- Allow formatting of long lines with "gq".
opt.formatoptions:append('q')
